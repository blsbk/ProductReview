# OliveYoung Product Review Analysis
The project is about screening Korean cosmetics trends by using product reviews on OliveYoung website.

OliveYoung is the Korea No.1 Health & Beauty retailer with over million users on their website. Thus, OliveYoung is the most representative drugstore platform to get data regarding customers’ behavior and trend of their demand.

It aims to answer following research questions:
* What kind of characteristics of certain product types are frequently mentioned by consumers?
* What kind of insights can we give to cosmetic firms for the marketing strategies of the product types? (by using the analysis results)

# Data Collection (Python)
Web crawling of 4 product types: skincare, cleansing, eye makeup, men’s cosmetic (skincare)
- 10 products for each type
- 100 reviews for each product
- 1,000 reviews for each product type
- 4,000 reviews in total
<img width="373" alt="image" src="https://user-images.githubusercontent.com/101795603/180955591-ad068b59-c591-4258-9f6c-eb7aca3da394.png">

# Analysis Results
* Noun Frequency Analysis
In order to retrieve nouns Korean Natural Language Processing (KoNLP) was done and prepared data for further analysis. You can refer to the codes in "빈도분석.R" file. Frequency analysis for each product group was saved to csv files. 
<img width="250" alt="image" src="https://user-images.githubusercontent.com/101795603/181478758-87cd5660-dba7-4872-bae7-408e0fd2d548.png"> <img width="264" alt="image" src="https://user-images.githubusercontent.com/101795603/181476724-f24bbd0c-207a-4fd2-b105-7133bf44d75b.png"> <img width="260" alt="image" src="https://user-images.githubusercontent.com/101795603/181476746-311910d1-416a-412d-bfe5-84182a4c355e.png"> <img width="265" alt="image" src="https://user-images.githubusercontent.com/101795603/181476772-ef1f1c3b-59fc-4abe-977f-3043cc24d7e8.png">

* Social Network Analysis
This method, basicly, looks for relationship between the nouns that appeared together in one sentence. The word clusters that appeared more than 200 times in one sentence were selected for further analysis. 
Next, assuming, the words related to each other if they appear together, network analysis was done using incidence matrix. The result is the adjacency matrix(comatrix) for each product group that was saved to seperate csv files. (for code refer to the SNA code.R file)
Utilizing the VOSviewer, visualization tool for  bibliography network analysis, the results in previous step (csv comatrix files) were visualiized as follows:
- Skincare
<img width="419" alt="image" src="https://user-images.githubusercontent.com/101795603/181478358-4d717a72-05c9-439b-abbe-c6d92aa0dc02.png">
- Cleansing
<img width="389" alt="image" src="https://user-images.githubusercontent.com/101795603/181479127-8b737996-d069-4d8d-a648-9717fb1ed502.png">
- Eye makeup
<img width="379" alt="image" src="https://user-images.githubusercontent.com/101795603/181479168-6a8c6c3d-63f6-4861-8e02-4e7c96108c55.png">
- Men
<img width="417" alt="image" src="https://user-images.githubusercontent.com/101795603/181479296-d9be466d-5987-4a57-91f6-fbcd672a7077.png">

# Marketing Insights
<img width="858" alt="Screen Shot 2022-07-28 at 7 04 57 PM" src="https://user-images.githubusercontent.com/101795603/181479783-cf3f144c-97c9-4f10-a7b0-67b16bdeefe1.png">
<img width="858" alt="Screen Shot 2022-07-28 at 7 05 13 PM" src="https://user-images.githubusercontent.com/101795603/181479829-5e8c818b-6eae-403d-aad4-9f3c7952e04c.png">
<img width="858" alt="Screen Shot 2022-07-28 at 7 05 25 PM" src="https://user-images.githubusercontent.com/101795603/181479858-2a31b863-dbde-400a-8767-ea19d8d35bab.png">
<img width="858" alt="Screen Shot 2022-07-28 at 7 05 34 PM" src="https://user-images.githubusercontent.com/101795603/181479883-3190f481-b1cc-4cb5-b6cd-09abceb72b98.png">
