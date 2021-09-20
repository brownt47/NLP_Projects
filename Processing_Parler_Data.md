```r


##############################################################
#########                                   ##################
#########   Generate the comment text files ##################
#########                                   ##################
##############################################################

setwd("D:\\Parler ChatBot\\parler_data0000\\test")

#create a list of the files from your target directory
file_list <- list.files(path="D:\\Parler ChatBot\\parler_data0000\\test")

#initiate a blank data frame, each iteration of the loop will append the data from the given file to this variable
dataset <- data.frame()

#loop thru files in folder
for (i in 1:length(file_list)){
  filename = file_list[i]
  DF<- ndjson::stream_in(path=filename)
  comments = DF[DF$body !="",]$body
  csv_filename <- paste('Parler0000_',  filename,".csv", sep="")
  write.csv(comments,csv_filename, row.names = FALSE)
  print(length(comments))
  }

##############################################################
#########                                   ##################
#########   Merge the comment text files    ##################
#########                                   ##################
##############################################################

setwd("D:\\Parler ChatBot\\parler_data0000\\test\\text")

file_list <- list.files(path="D:\\Parler ChatBot\\parler_data0000\\test\\text")

dataset <- data.frame()

for (i in 1:length(file_list)){
  filename = file_list[i]
  DF <- read.csv(file = filename)
  dataset <-rbind(dataset, DF)
  print(summary(dataset))
}

write.csv(dataset,"full_comments.csv", row.names = FALSE)




