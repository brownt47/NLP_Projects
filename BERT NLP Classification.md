
# BERT classification exercise using a fake news dataset posted on kaggle here: link


## Import the libraries
```

  !pip3 install ktrain

  import os.path 
  import numpy as np
  import pandas as pd
  import tensorflow as tf
  import ktrain
  from ktrain import text 

```

## Preprocessing the data
```
  FakeNews = pd.read_csv('Fake.csv')
  RealNews = pd.read_csv('True.csv')
```
## Encoding the data for BERT
```
  FakeNews['pos'] = 1
  FakeNews['neg'] = 0
  RealNews['pos'] = 0
  RealNews['neg'] = 1
```

## Combining the datasets
```
  dataset = pd.concat([FakeNews, RealNews])
  dataset = dataset[['text','pos','neg']]
  dataset
```
output:
```
	                                           text	pos neg
0	Donald Trump just couldn t wish all Americans ... 1 0
1	House Intelligence Committee Chairman Devin Nu... 1 0
2	On Friday, it was revealed that former Milwauk... 1 0	   
3	On Christmas day, Donald Trump announced that ... 1 0
4	Pope Francis used his annual Christmas Day mes... 1 0
...
44898 rows × 3 columns
```
## Preparing dataset preproc for BERT

### Creating the training and test sets
```
  (x_train, y_train), (x_test, y_test), preproc = text.texts_from_df(dataset, 'text',
                                                                       label_columns = ['pos', 'neg'],
                                                                       maxlen = 500,
                                                                       ngram_range = 1,
                                                                       preprocess_mode = 'bert')
```
## Building the BERT Model
```
  model = text.text_classifier(name = 'bert',
                               train_data = (x_train, y_train),
                               preproc = preproc)
```
## Training the BERT Model
```
   learner = ktrain.get_learner(model = model, 
                               train_data = (x_train, y_train),
                               val_data = (x_test, y_test),
                               batch_size = 6)

  learner.fit_onecycle(lr = 2e-5,
                       epochs = 1)
```
## Results
```
begin training using onecycle policy with max lr of 2e-05...
6735/6735 [==============================] - 7117s 1s/step - loss: 0.0636 - accuracy: 0.9811 - val_loss: 0.0019 - val_accuracy: 0.9996
<tensorflow.python.keras.callbacks.History at 0x7f4ddd9efe80>
```                     
