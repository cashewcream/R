#R Iris 
#author: Pyone Thwe
#08/06/2023

# I explored the built-in iris dataset in R. This dataset includes measurements of sepal length, sepal width, petal length, and petal width in centimeters and three species of iris. The species are setosa, versicolor, and virginica.

# preview of data
head(iris)

A data.frame: 6 × 5
Sepal.Length	Sepal.Width	Petal.Length	Petal.Width	Species
<dbl>	<dbl>	<dbl>	<dbl>	<fct>
1	5.1	3.5	1.4	0.2	setosa
2	4.9	3.0	1.4	0.2	setosa
3	4.7	3.2	1.3	0.2	setosa
4	4.6	3.1	1.5	0.2	setosa
5	5.0	3.6	1.4	0.2	setosa
6	5.4

# load necessary packages
library(tidyverse)

# Convert into tbl_df a tibble data frame
iris_data <-as_tibble(iris)
iris_data

#omit NA
na.omit(iris_data)

# Various ways to remove duplicates:
# by duplicated
iris_data[!duplicated(iris_data),]

# by columns
iris_data %>% 
  distinct(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width,.keep_all = TRUE)

# by distinct
distinct(iris_data)
# For removing duplicates, the three similar methods above resulted in the same which is removing 1 duplicate row

# mean of sepal length, sepal width, petal length, and petal width combined among all species 
map(iris_data,mean)

$Sepal.Length
5.84333333333333
$Sepal.Width
3.05733333333333
$Petal.Length
3.758
$Petal.Width
1.19933333333333
$Species
<NA>

# I tested out different ways to pull mean of sepal.length of each species.
iris_data %>%
    select(Sepal.Length, Species)%>%
    filter(Species == "setosa") %>%
    group_by(Species)%>%
    summarise(average_sepal.length = mean(Sepal.Length))
   
iris_data %>%
    select(Sepal.Length, Species)%>%
    filter(Species == "versicolor") %>%
    group_by(Species)%>%
    summarise(average_sepal.length = mean(Sepal.Length))

iris_data %>%
    select(Sepal.Length, Sepal.Width, Species)%>%
    filter(Species == "virginica") %>%
    group_by(Species)%>%
    summarise(average_sepal.length = mean(Sepal.Length))

A tibble: 1 × 2
Species	average_sepal.length
<fct>	<dbl>
setosa	5.006

A tibble: 1 × 2
Species	average_sepal.length
<fct>	<dbl>
versicolor	5.936

A tibble: 1 × 2
Species	average_sepal.length
<fct>	<dbl>
virginica	6.588

# I find that summarizing the average of sepal length, sepal width, petal length, and petal width grouped by species is a better option to produce the summary in this case. 

iris_data %>% 
    group_by(Species)%>%
    summarize_if(is.numeric, mean)

A tibble: 3 × 5
Species	Sepal.Length	Sepal.Width	Petal.Length	Petal.Width
<fct>	<dbl>	<dbl>	<dbl>	<dbl>
setosa	5.006	3.428	1.462	0.246
versicolor	5.936	2.770	4.260	1.326
virginica	6.588	2.974	5.552	2.026

# Findings
# Setosa species has the smallest petal length and petal width. Versicolor species has average petal length and petal width. Virginica species has the highest petal length and petal width.
# Versicolor species has the smallest sepal width. Virginica species came in second and setosa species has the largest sepal width.
# Virginica species has the longest sepal length, versicolor has the second longest sepal length and setosa species has the shortest sepal length.

#Visualizations

# Plotted Petal.Length, Petal.Width, Sepal.Width, and Sepal.Length
# Then, I organized the plots by plot_grid from cowplot package

library(ggplot2)
library(cowplot)

iris_petal.length <- iris_data %>%
    ggplot(aes(x = Species, y = Petal.Length))+
    geom_point()

iris_petal.width <- iris_data %>%
    ggplot(aes(x = Species, y = Petal.Width))+
    geom_point()

iris_sepal.width <- iris_data %>%
    ggplot(aes(x = Species, y = Sepal.Width))+
    geom_point()

iris_sepal.length <- iris_data %>%
    ggplot(aes(x = Species, y = Sepal.Length))+
    geom_point()

plot_grid(iris_petal.length, iris_petal.width, iris_sepal.width, iris_sepal.length, labels = "AUTO")

#In this scenario, boxplot is a better option to display data distribution through their quartiles
# upper extreme
# upper quartile
# median
# lower quartile
# whisker
# lower extreme
# outlier or single data point

library(ggplot2)
library(cowplot)

iris_petal.length <- iris_data %>%
    ggplot(aes(x = Species, y = Petal.Length))+
    geom_boxplot()

iris_petal.width <- iris_data %>%
    ggplot(aes(x = Species, y = Petal.Width))+
    geom_boxplot()

iris_sepal.width <- iris_data %>%
    ggplot(aes(x = Species, y = Sepal.Width))+
    geom_boxplot()

iris_sepal.length <- iris_data %>%
    ggplot(aes(x = Species, y = Sepal.Length))+
    geom_boxplot()

plot_grid(iris_petal.length, iris_petal.width, iris_sepal.width, iris_sepal.length, labels = "AUTO")

# please refer to my notebook for data visualization portion https://www.kaggle.com/code/pyonet/r-iris


