library(stringr)
library(dplyr)
library(multilinguer)
library(KoNLP)
library(tidytext)

# 1. cleansing products

# data preprocessing
cleansing = raw_cleansing[,c(2, 3)]

cleansing$리뷰 = raw_cleansing$리뷰 %>%
  str_replace_all('[^가-힣]', ' ') %>%  # remove everything except for korean characters
  str_squish() %>%  # remove consecutive spaces
  as_tibble()  # convert to tibble

# tokenization based on nouns
cleansing_noun = cleansing$리뷰 %>%
  unnest_tokens(input = value, output = word, token = extractNoun)

# noun frequency
cleansing_noun = cleansing_noun %>%
  count(word, sort = T) %>%  # count the number of each noun, descending order
  filter(str_count(word) > 1)  # keep nouns that has more than one letter

write.csv(cleansing_noun, file = '/Users/heesunyoon/Desktop/PNU/2021.2학기/마케팅애널리틱스/group project/oliveyoungdata/cleansing noun frequency analysis.csv')


# 2. eye makeup products

# data preprocessing
eye = raw_eye[,c(2, 3)]

eye$리뷰 = raw_eye$리뷰 %>%
  str_replace_all('[^가-힣]', ' ') %>%  # remove everything except for korean characters
  str_squish() %>%  # remove consecutive spaces
  as_tibble()  # convert to tibble

# tokenization based on nouns
eye_noun = eye$리뷰 %>%
  unnest_tokens(input = value, output = word, token = extractNoun)

# noun frequency
eye_noun = eye_noun %>%
  count(word, sort = T) %>%  # count the number of each noun, descending order
  filter(str_count(word) > 1)  # keep nouns that has more than one letter

write.csv(eye_noun, file = '/Users/heesunyoon/Desktop/PNU/2021.2학기/마케팅애널리틱스/group project/oliveyoungdata/eye noun frequency analysis.csv')


# 3. men product

# data preprocessing
men = raw_men[,c(2, 3)]

men$리뷰 = raw_men$리뷰 %>%
  str_replace_all('[^가-힣]', ' ') %>%  # remove everything except for korean characters
  str_squish() %>%  # remove consecutive spaces
  as_tibble()  # convert to tibble

# tokenization based on nouns
men_noun = men$리뷰 %>%
  unnest_tokens(input = value, output = word, token = extractNoun)

# noun frequency
men_noun = men_noun %>%
  count(word, sort = T) %>%  # count the number of each noun, descending order
  filter(str_count(word) > 1)  # keep nouns that has more than one letter

write.csv(men_noun, file = '/Users/heesunyoon/Desktop/PNU/2021.2학기/마케팅애널리틱스/group project/oliveyoungdata/men noun frequency analysis.csv')


# 4. skincare product

# data preprocessing
skin = raw_skin[,c(2, 3)]

skin$리뷰 = raw_skin$리뷰 %>%
  str_replace_all('[^가-힣]', ' ') %>%  # remove everything except for korean characters
  str_squish() %>%  # remove consecutive spaces
  as_tibble()  # convert to tibble

# tokenization based on nouns
skin_noun = skin$리뷰 %>%
  unnest_tokens(input = value, output = word, token = extractNoun)

# noun frequency
skin_noun = skin_noun %>%
  count(word, sort = T) %>%  # count the number of each noun, descending order
  filter(str_count(word) > 1)  # keep nouns that has more than one letter

write.csv(skin_noun, file = '/Users/heesunyoon/Desktop/PNU/2021.2학기/마케팅애널리틱스/group project/oliveyoungdata/skincare noun frequency analysis.csv')

