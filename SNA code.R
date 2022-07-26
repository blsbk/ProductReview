library(tidyverse)
library(reshape)
library(readxl)
library(readr)
library(dplyr)
library(stringr)
library(textclean)
library(tidytext)
library(KoNLP)
library(widyr)
library(tidygraph)
library(ggraph)
library(showtext)
library(tidyr)

rawdata <- read_excel("Desktop/rawdata.xlsx")
View(skincare)

# 각각의 제품군에 해당하는 서브셋 생성
skincare = subset(rawdata, subset = product_type == 'skincare')
eye = subset(rawdata, subset = product_type == 'eye')
cleansing = subset(rawdata, subset = product_type == 'cleansing')
men = subset(rawdata, subset = product_type == 'men')

# 전처리
proc_skincare = skincare %>%
  select(review) %>%
  mutate(review = str_replace_all(review, '[^가-힣]', ' '), review = str_squish(review), id = row_number())

proc_eye = eye %>%
  select(review) %>%
  mutate(review = str_replace_all(review, '[^가-힣]', ' '), review = str_squish(review), id = row_number())

proc_cleansing = cleansing %>%
  select(review) %>%
  mutate(review = str_replace_all(review, '[^가-힣]', ' '), review = str_squish(review), id = row_number())

proc_men = men %>%
  select(review) %>%
  mutate(review = str_replace_all(review, '[^가-힣]', ' '), review = str_squish(review), id = row_number())

# 형태소 분석기로 토큰화
cleansing_pos = proc_cleansing %>%
  unnest_tokens(input = review, output = word, token = SimplePos22, drop = F)

eye_pos = proc_eye %>%
  unnest_tokens(input = review, output = word, token = SimplePos22, drop = F)

skincare_pos = proc_skincare %>%
  unnest_tokens(input = review, output = word, token = SimplePos22, drop = F)

men_pos = proc_men %>%
  unnest_tokens(input = review, output = word, token = SimplePos22, drop = F)

# 품사 분리하여 행 구성 (위의 결과에서는 여러 품사가 함께 같은 행에 나오는 경우가 있음)
cleansing_pos = cleansing_pos %>%
  separate_rows(word, sep = '[+]')

eye_pos = eye_pos %>%
  separate_rows(word, sep = '[+]')

skincare_pos = skincare_pos %>%
  separate_rows(word, sep = '[+]')

men_pos = men_pos %>%
  separate_rows(word, sep = '[+]')

# 명사 추출
cleansing_noun = cleansing_pos %>%
  filter(str_detect(word, '/n')) %>%
  mutate(word = str_remove(word, '/.*$'))

eye_noun = eye_pos %>%
  filter(str_detect(word, '/n')) %>%
  mutate(word = str_remove(word, '/.*$'))

skincare_noun = skincare_pos %>%
  filter(str_detect(word, '/n')) %>%
  mutate(word = str_remove(word, '/.*$'))

men_noun = men_pos %>%
  filter(str_detect(word, '/n')) %>%
  mutate(word = str_remove(word, '/.*$'))

#SNA 분석 - SKINCARE
skincare_noun = skincare_noun[,2:3]

# 어간이 두 글자 이상인 경우만 분석 대상
target_skincare_noun <- skincare_noun %>% filter(str_length(word) >= 2)

# 어간별 출현 빈도
words_freq_skincare=count(target_skincare_noun, word, sort=T) 

# 200회 이상 출현한 어간만 분석 대상으로 함
target_words_skincare=filter(words_freq_skincare,n>200)
n_words_skincare = dim(target_words_skincare)[1]
n_words_skincare

# 분석 대상 어간만 데이터에서 추출
target_skincare_noun=target_skincare_noun %>% filter(word %in% target_words_skincare$word)

# 문장 출현을 바탕으로 그래프 생성 (같은 문장에 나타난 어간은 서로 관계 있다고 가정함)
g1 = graph.data.frame(target_skincare_noun)

# 방향성은 없는 것으로 가정하고, Incidence Matrix을 이용하여 adjacency matrix 생성
g1_type=c(rep(0,vcount(g1)-n_words_skincare),rep(1,n_words_skincare))
co.matrix_skincare = t(as_incidence_matrix(g1,types=g1_type)) %*% as_incidence_matrix(g1,types=g1_type)

# heatmap
heatmap(co.matrix_skincare)

# visualization using VOS viewer
write.table(co.matrix_skincare,"Comatrix_Skincare.csv",col.names=FALSE,sep=",")

# SNA - CLEANSING
cleansing_noun = cleansing_noun[,2:3]

target_cleansing_noun <- cleansing_noun %>% filter(str_length(word) >= 2)

words_freq_cleansing=count(target_cleansing_noun, word, sort=T) 

target_words_cleansing=filter(words_freq_cleansing,n>200)
n_words_cleansing = dim(target_words_cleansing)[1]
n_words_cleansing

target_cleansing_noun=target_cleansing_noun %>% filter(word %in% target_words_cleansing$word)

g2 = graph.data.frame(target_cleansing_noun)
g2_type=c(rep(0,vcount(g2)-n_words_cleansing),rep(1,n_words_cleansing))
co.matrix_cleansing = t(as_incidence_matrix(g2,types=g2_type)) %*% as_incidence_matrix(g2,types=g2_type)

heatmap(co.matrix_cleansing)
write.table(co.matrix_cleansing,"Comatrix_Cleansing.csv",col.names=FALSE,sep=",")


# SNA - EYE
eye_noun = eye_noun[,2:3]

target_eye_noun <- eye_noun %>% filter(str_length(word) >= 2)

words_freq_eye=count(target_eye_noun, word, sort=T) 

target_words_eye=filter(words_freq_eye,n>200)
n_words_eye = dim(target_words_eye)[1]
n_words_eye

target_eye_noun=target_eye_noun %>% filter(word %in% target_words_eye$word)
g3 = graph.data.frame(target_eye_noun)
g3_type=c(rep(0,vcount(g3)-n_words_eye),rep(1,n_words_eye))
co.matrix_eye = t(as_incidence_matrix(g3,types=g3_type)) %*% as_incidence_matrix(g3,types=g3_type)

heatmap(co.matrix_eye)
write.table(co.matrix_eye,"Comatrix_Eye.csv",col.names=FALSE,sep=",")

# SNA - Men
men_noun = men_noun[,2:3]

target_men_noun <- men_noun %>% filter(str_length(word) >= 2)

words_freq_men=count(target_men_noun, word, sort=T) 

target_words_men=filter(words_freq_men,n>200)
n_words_men = dim(target_words_men)[1]
n_words_men

target_men_noun=target_men_noun %>% filter(word %in% target_words_men$word)
g4 = graph.data.frame(target_men_noun)
g4_type=c(rep(0,vcount(g4)-n_words_men),rep(1,n_words_men))
co.matrix_men = t(as_incidence_matrix(g4,types=g4_type)) %*% as_incidence_matrix(g4,types=g4_type)

heatmap(co.matrix_men)
write.table(co.matrix_men,"Comatrix_Men.csv",col.names=FALSE,sep=",")
