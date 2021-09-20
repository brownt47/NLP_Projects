{
  "nbformat": 4,
  "nbformat_minor": 0,
  "metadata": {
    "colab": {
      "name": "Processing_Parler_Data_R.ipynb",
      "provenance": [],
      "authorship_tag": "ABX9TyPpn6R+bvjK1RLwyvpuGnxd"
    },
    "kernelspec": {
      "name": "python3",
      "display_name": "Python 3"
    },
    "language_info": {
      "name": "python"
    }
  },
  "cells": [
    {
      "cell_type": "code",
      "metadata": {
        "id": "3x5vEt1wWFv6"
      },
      "source": [
        "##############################################################\n",
        "#########                                   ##################\n",
        "#########   Generate the comment text files ##################\n",
        "#########                                   ##################\n",
        "##############################################################\n",
        "\n",
        "setwd(\"D:\\\\Parler ChatBot\\\\parler_data0000\\\\test\")\n",
        "\n",
        "#create a list of the files from your target directory\n",
        "file_list <- list.files(path=\"D:\\\\Parler ChatBot\\\\parler_data0000\\\\test\")\n",
        "\n",
        "#initiate a blank data frame, each iteration of the loop will append the data from the given file to this variable\n",
        "dataset <- data.frame()\n",
        "\n",
        "#loop thru files in folder\n",
        "for (i in 1:length(file_list)){\n",
        "  filename = file_list[i]\n",
        "  DF<- ndjson::stream_in(path=filename)\n",
        "  comments = DF[DF$body !=\"\",]$body\n",
        "  csv_filename <- paste('Parler0000_',  filename,\".csv\", sep=\"\")\n",
        "  write.csv(comments,csv_filename, row.names = FALSE)\n",
        "  print(length(comments))\n",
        "  }\n",
        "\n",
        "##############################################################\n",
        "#########                                   ##################\n",
        "#########   Merge the comment text files    ##################\n",
        "#########                                   ##################\n",
        "##############################################################\n",
        "\n",
        "setwd(\"D:\\\\Parler ChatBot\\\\parler_data0000\\\\test\\\\text\")\n",
        "\n",
        "file_list <- list.files(path=\"D:\\\\Parler ChatBot\\\\parler_data0000\\\\test\\\\text\")\n",
        "\n",
        "dataset <- data.frame()\n",
        "\n",
        "for (i in 1:length(file_list)){\n",
        "  filename = file_list[i]\n",
        "  DF <- read.csv(file = filename)\n",
        "  dataset <-rbind(dataset, DF)\n",
        "  print(summary(dataset))\n",
        "}\n",
        "\n",
        "write.csv(dataset,\"full_comments.csv\", row.names = FALSE)\n",
        "\n",
        "\n",
        "\n",
        "\n"
      ],
      "execution_count": null,
      "outputs": []
    }
  ]
}