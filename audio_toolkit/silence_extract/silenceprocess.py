import os
import argparse
import shutil
import pdb

source_path = './SilenceDB'
inter_path  = './after_data'
train_path  = './train'
dev_path    = './dev'
test_path   = './test'

train_list = []
dev_list = []
test_list = []
data_list = [train_list,dev_list,test_list]

def make_dir(path):
  if not os.path.isdir(path) :
    os.mkdir(path)

def preprocess(args) :
  # Source directory to inter directory
  source_dirs = os.listdir(source_path)
  make_dir(inter_path)
  print(source_path , " > ", inter_path)
  for dir in  source_dirs :
    dir_path = os.path.join(source_path,dir)
    files = os.listdir(dir_path)

    for file in files :
      # print(file)
      source_file = os.path.join(dir_path, file)
      inter_file = os.path.join(inter_path, file)
      shutil.copy(source_file, inter_file)


  # intermediate directory to destination directory
  inter_files = os.listdir(inter_path)
  file_dict = {}
  make_dir(train_path)
  make_dir(dev_path)
  make_dir(test_path)

  # 전체 데이터를 Dict에 담는다.
  for file in inter_files :
    extension = file.split(".")[-1]
    if extension == "wav" :
      file_name = file.split(".wav")[0]
    elif extension == "txt" :
      file_name = file.split(".txt")[0]

    if file == '.DS_Store' :
      os.remove(os.path.join(inter_path, file))

    if file_name in file_dict :
      file_dict[file_name] = 1
    else :
      file_dict[file_name] = 0

  # Dict에서 train, dev, test를 list에 담아준다
  count = 0
  len_dict = len(file_dict)
  for file_name, value in file_dict.items() :
    try :
      assert value == 0, '정합성 오류 : txt - wav 페어가 맞지 않습니다. : {}'.format(value)

      progress = count / len_dict
      if 0.0 < progress < args.train/10 :
        train_list.append(file_name)
      elif args.train/10 < progress < (args.train + args.dev)/10 :
        dev_list.append(file_name)
      else :
        test_list.append(file_name)
    except AssertionError as e :
      print(e, " : ", file_name)
    count += 1

  # 각 list 내용을 train, dev, test 폴더에 생성한다.
  for i, file_list in enumerate(data_list):
    if i == 0 :
      des_path = train_path
    elif i == 1 :
      des_path = dev_path
    else :
      des_path = test_path

    # list sort
    file_list.sort()
    print(inter_path , " > ", des_path)

    for file_name in file_list :
      inter_file = os.path.join(inter_path, file_name)
      des_wav_file = os.path.join(des_path,"wav.scp")
      des_train_file = os.path.join(des_path,"text")
      des_utt2spk_file = os.path.join(des_path,"utt2spk")

      with open(des_wav_file, 'a', encoding='utf-8') as f :
        f.write(file_name + " " + inter_file + ".wav\n")

    #   with open(inter_file + ".txt", 'r', encoding='euc-kr') as f :
    #     text = f.read()
      with open(des_train_file, 'a', encoding='utf-8') as f2 :
        f2.write(file_name + " " + "-\n")

      with open(des_utt2spk_file, 'a', encoding='utf-8') as f :
        f.write(file_name + " " + file_name + "\n")

def test() :
  # 정합성 테스트
  for i in range(3):
    if i == 0 :
      des_path = train_path
    elif i == 1 :
      des_path = dev_path
    else :
      des_path = test_path

  # text file의 key와 utt2spk file의 key가 맞는지 검사
  text_list = []
  utt2spk_list = []
  wav_list = []
  with open(os.path.join(des_path,'text'), 'r', encoding='utf-8')  as f :
    while True:
      line = f.readline()
      if not line: break
      text_list.append(line.split(' ')[0])

  with open(os.path.join(des_path,'utt2spk'), 'r', encoding='utf-8')  as f :
    while True:
      line = f.readline()
      if not line: break
      utt2spk_list.append(line.split(' ')[0])

  with open(os.path.join(des_path,'wav.scp'), 'r', encoding='utf-8')  as f :
    while True:
      line = f.readline()
      if not line: break
      wav_list.append(line.split(' ')[0])

  assert text_list == utt2spk_list, 'text file과 utt2spk file의 key가 일치하지 않습니다'
  assert text_list == wav_list, 'text file과 wav.scp file의 key가 일치하지 않습니다'
  assert utt2spk_list == wav_list, 'utt2spk file과 wav.scp file의 key가 일치하지 않습니다'




if __name__ == "__main__" :
  parser = argparse.ArgumentParser()
  parser.add_argument('-t', '--train', type=int, default=7, help='train data ratio')
  parser.add_argument('-d', '--dev',   type=int, default=2, help='dev data ratio')
  parser.add_argument('-s', '--test',  type=int, default=1, help='test data ratio')

  args = parser.parse_args()

  try :
    assert args.train + args.dev + args.test == 10, 'Data 비율 설정 오류'

    preprocess(args)

    test()
  except AssertionError as e :
    print("Assertion Error : ", e)