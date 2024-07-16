# SwiftFFmpeg

Most ideas and code similar to `sunlubo/SwiftFFmpeg`, but with backend powered by `tylerjonesio/ffmpeg-kit-spm`


### Linux Support

This package has linux support, but in a different way than for Apple platforms. You need to have `libavformat` (>=5.0) installed, e.g. with:
```bash
apt-get install -y ffmpeg
apt-get install -y libavcodec-dev libavformat-dev libavutil-dev libswscale-dev libavfilter-dev libswresample-dev
```
