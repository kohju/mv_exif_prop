# mv_exif_prop

move the jpg file with mkdir date directory by exif date.

日付のディレクトリを掘って、jpgファイルをコピーするプログラム。

## prepare 事前準備

Install this library from CPAN.

perlの下記のライブラリを使うので、適当に環境に合わせてインストールする。


```
sudo perl -MCPAN -e"install Image::MetaData::JPEG"
```


## Usage 使い方


'''
mv *.JPG
'''

