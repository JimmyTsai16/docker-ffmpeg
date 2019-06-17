FROM lsiobase/alpine:3.9 as buildstage

# set version label
ARG FFMPEG_VERSION

# common env
ENV \
 MAKEFLAGS="-j4"

# versions
ENV \
 AOM=v1.0.0 \
 FDKAAC=0.1.5 \
 FFMPEG_HARD=4.1.3 \
 FONTCONFIG=2.12.4 \
 FREETYPE=2.5.5 \
 FRIBIDI=0.19.7 \
 KVAZAAR=1.2.0 \
 LAME=3.99.5 \
 LIBASS=0.13.7 \
 LIBVIDSTAB=1.1.0 \
 OGG=1.3.2 \
 OPENCOREAMR=0.1.5 \
 OPENJPEG=2.3.1 \
 OPUS=1.2 \
 THEORA=1.1.1 \
 VORBIS=1.3.5 \
 VPX=1.8.0 \
 X265=3.0 \
 XVID=1.3.4 

RUN \
 echo "**** install build packages ****" && \
 echo https://ffmpeg.org/releases/ffmpeg-${FFMPEG}.tar.bz2 && \ 
 apk add \
	autoconf \
	automake \
	bzip2 \
	ca-certificates \
	cmake \
	curl \
	diffutils \
	expat \
	g++ \
	gcc \
	git \
	gperf \
	jq \
	expat-dev \
	libgomp \
	libgcc \
	openssl-dev \
	libtool \
	make \
	nasm \
	perl \
	pkgconfig \
	python \
	yasm \
	zlib-dev

# grab source code
RUN \
 mkdir -p \
	/tmp/aom \
	/tmp/fdk-aac \
	/tmp/fontconfig \
	/tmp/freetype \
	/tmp/fribidi \
	/tmp/kvazaar \
	/tmp/lame \
	/tmp/libass \
	/tmp/ogg \
	/tmp/opencore-amr \
	/tmp/openjpeg \
	/tmp/opus \
	/tmp/theora \
	/tmp/vid.stab \
	/tmp/vorbis \
	/tmp/vpx \
	/tmp/x264 \
	/tmp/x265 \
	/tmp/xvid
RUN \
 echo "**** grabbing aom ****" && \
 git clone \
	--branch ${AOM} \
	--depth 1 https://aomedia.googlesource.com/aom \
	/tmp/aom
RUN \
 echo "**** grabbing fdk-aac ****" && \
 curl -Lf \
	https://github.com/mstorsjo/fdk-aac/archive/v${FDKAAC}.tar.gz | \
	tar -zx --strip-components=1 -C /tmp/fdk-aac
RUN \
 echo "**** grabbing fontconfig ****" && \
 curl -Lf \
	https://www.freedesktop.org/software/fontconfig/release/fontconfig-${FONTCONFIG}.tar.bz2 | \
	tar -jx --strip-components=1 -C /tmp/fontconfig
RUN \
 echo "**** grabbing freetype ****" && \
 curl -Lf \
	https://download.savannah.gnu.org/releases/freetype/freetype-${FREETYPE}.tar.gz | \
	tar -zx --strip-components=1 -C /tmp/freetype
RUN \
 echo "**** grabbing fribidi ****" && \
 curl -Lf \
	https://github.com/fribidi/fribidi/archive/${FRIBIDI}.tar.gz | \
	tar -zx --strip-components=1 -C /tmp/fribidi
RUN \
 echo "**** grabbing kvazaar ****" && \
 curl -Lf \
	https://github.com/ultravideo/kvazaar/archive/v${KVAZAAR}.tar.gz | \
	tar -zx --strip-components=1 -C /tmp/kvazaar
RUN \
 echo "**** grabbing lame ****" && \
 curl -Lf \
	http://downloads.sourceforge.net/project/lame/lame/3.99/lame-${LAME}.tar.gz | \
	tar -zx --strip-components=1 -C /tmp/lame
RUN \
 echo "**** grabbing libass ****" && \
 curl -Lf \
	https://github.com/libass/libass/archive/${LIBASS}.tar.gz | \
	tar -zx --strip-components=1 -C /tmp/libass
RUN \
 echo "**** grabbing ogg ****" && \
 curl -Lf \
	http://downloads.xiph.org/releases/ogg/libogg-${OGG}.tar.gz | \
	tar -zx --strip-components=1 -C /tmp/ogg
RUN \
 echo "**** grabbing opencore-amr ****" && \
 curl -Lf \
	http://downloads.sourceforge.net/project/opencore-amr/opencore-amr/opencore-amr-${OPENCOREAMR}.tar.gz | \
	tar -zx --strip-components=1 -C /tmp/opencore-amr
RUN \
 echo "**** grabbing openjpeg ****" && \
 curl -Lf \
	https://github.com/uclouvain/openjpeg/archive/v${OPENJPEG}.tar.gz | \
	tar -zx --strip-components=1 -C /tmp/openjpeg
RUN \
 echo "**** grabbing opus ****" && \
 curl -Lf \
	https://archive.mozilla.org/pub/opus/opus-${OPUS}.tar.gz | \
	tar -zx --strip-components=1 -C /tmp/opus
RUN \
 echo "**** grabbing theora ****" && \
 curl -Lf \
	http://downloads.xiph.org/releases/theora/libtheora-${THEORA}.tar.gz | \
	tar -zx --strip-components=1 -C /tmp/theora
RUN \
 echo "**** grabbing vid.stab ****" && \
 curl -Lf \
	https://github.com/georgmartius/vid.stab/archive/v${LIBVIDSTAB}.tar.gz | \
	tar -zx --strip-components=1 -C /tmp/vid.stab
RUN \
 echo "**** grabbing vorbis ****" && \
 curl -Lf \
	http://downloads.xiph.org/releases/vorbis/libvorbis-${VORBIS}.tar.gz | \
	tar -zx --strip-components=1 -C /tmp/vorbis
RUN \
 echo "**** grabbing vpx ****" && \
 curl -Lf \
	https://github.com/webmproject/libvpx/archive/v${VPX}.tar.gz | \
	tar -zx --strip-components=1 -C /tmp/vpx
RUN \
 echo "**** grabbing x264 ****" && \
 curl -Lf \
	https://download.videolan.org/pub/videolan/x264/snapshots/last_stable_x264.tar.bz2 | \
	tar -jx --strip-components=1 -C /tmp/x264
RUN \
 echo "**** grabbing x265 ****" && \
 curl -Lf \
	https://download.videolan.org/pub/videolan/x265/x265_${X265}.tar.gz | \
	tar -zx --strip-components=1 -C /tmp/x265
RUN \
 echo "**** grabbing xvid ****" && \
 curl -Lf \
	http://downloads.xvid.org/downloads/xvidcore-${XVID}.tar.gz | \
	tar -zx --strip-components=1 -C /tmp/xvid


# compilation of external plugins for ffmpeg
RUN \
 echo "**** compiling aom ****" && \
 cd /tmp/aom && \
 rm -rf \
	CMakeCache.txt \
	CMakeFiles && \
 mkdir -p \
	aom_build && \
 cd aom_build && \
 cmake \
	-DBUILD_SHARED_LIBS=0 .. && \
 make && \
 make install
RUN \
 echo "**** compiling fdk-aac ****" && \
 cd /tmp/fdk-aac && \
 autoreconf -fiv && \
 ./configure \
	--disable-shared \
	--enable-static && \
 make && \
 make install
RUN \
 echo "**** compiling freetype ****" && \
 cd /tmp/freetype && \
 ./configure \
	--disable-shared \
	--enable-static && \
 make && \
 make install
RUN \
 echo "**** compiling fontconfig ****" && \
 cd /tmp/fontconfig && \
 ./configure \
	--disable-shared \
	--enable-static && \
 make && \
 make install 
RUN \
 echo "**** compiling fribidi ****" && \
 cd /tmp/fribidi && \
 ./bootstrap --no-config && \
 ./configure \
	--disable-shared \
	--enable-static && \
 make -j 1 && \
 make install
RUN \
 echo "**** compiling kvazaar ****" && \
 cd /tmp/kvazaar && \
 ./autogen.sh && \
 ./configure \
	--disable-shared \
	--enable-static && \
 make && \
 make install
RUN \
 echo "**** compiling lame ****" && \
 cd /tmp/lame && \
 cp \
	/usr/share/automake-1.16/config.guess \
	config.guess && \
 cp \
        /usr/share/automake-1.16/config.sub \
        config.sub && \
 ./configure \
	--disable-frontend \
	--disable-shared \
	--enable-nasm \
	--enable-static && \
 make && \
 make install
RUN \
 echo "**** compiling libass ****" && \
 cd /tmp/libass && \
 ./autogen.sh && \
 ./configure \
	--disable-shared \
	--enable-static && \
 make && \
 make install
RUN \
 echo "**** compiling ogg ****" && \
 cd /tmp/ogg && \
 ./configure \
	--disable-shared \
	--enable-static && \
 make && \
 make install
RUN \
 echo "**** compiling opencore-amr ****" && \
 cd /tmp/opencore-amr && \
 ./configure \
	--disable-shared \
	--enable-static  && \
 make && \
 make install
RUN \
 echo "**** compiling openjpeg ****" && \
 cd /tmp/openjpeg && \
 rm -Rf \
	thirdparty/libpng/* && \
 curl -Lf \
	https://download.sourceforge.net/libpng/libpng-1.6.37.tar.gz | \
	tar -zx --strip-components=1 -C thirdparty/libpng/ && \
 cmake \
	-DBUILD_SHARED_LIBS=0 \
	-DBUILD_THIRDPARTY:BOOL=ON . && \
 make && \
 make install
RUN \
 echo "**** compiling opus ****" && \
 cd /tmp/opus && \
 autoreconf -fiv && \
 ./configure \
	--disable-shared \
	--enable-static && \
 make && \
 make install
RUN \
 echo "**** compiling theora ****" && \
 cd /tmp/theora && \
 cp \
	/usr/share/automake-1.16/config.guess \
	config.guess && \
 cp \
	/usr/share/automake-1.16/config.sub \
	config.sub && \
 curl -fL \
	'https://git.xiph.org/?p=theora.git;a=commitdiff_plain;h=7288b539c52e99168488dc3a343845c9365617c8' \
	> png.patch && \
 patch ./examples/png2theora.c < png.patch && \
 ./configure \
	--disable-shared \
	--enable-static && \
 make && \
 make install
RUN \
 echo "**** compiling vid.stab ****" && \
 cd /tmp/vid.stab && \
 cmake \
	-DBUILD_SHARED_LIBS=0 . && \
 make && \
 make install
RUN \
 echo "**** compiling vorbis ****" && \
 cd /tmp/vorbis && \
 ./configure \
	--disable-shared \
	--enable-static && \
 make && \
 make install
RUN \
 echo "**** compiling vpx ****" && \
 cd /tmp/vpx && \
 ./configure \
	--disable-debug \
	--disable-docs \
	--disable-examples \
	--disable-install-bins \
	--disable-shared \
	--disable-unit-tests \
	--enable-pic \
	--enable-static \
	--enable-vp8 \
	--enable-vp9 \
	--enable-vp9-highbitdepth && \
 make && \
 make install
RUN \
 echo "**** compiling x264 ****" && \
 cd /tmp/x264 && \
 ./configure \
	--disable-cli \
	--disable-shared \
	--enable-pic \
	--enable-static && \
 make && \
 make install
RUN \
 echo "**** compiling x265 ****" && \
 cd /tmp/x265/build/linux && \
 cmake \
	-G "Unix Makefiles" \
	-D ENABLE_CLI:BOOL=OFF \
	-D ENABLE_SHARED:BOOL=OFF ../../source && \
 make && \
 make install
RUN \
 echo "**** compiling xvid ****" && \
 cd /tmp/xvid/build/generic && \
 ./configure && \ 
 make && \
 make install

# main ffmpeg compile
RUN \
 echo "**** Versioning ****" && \
 if [ -z ${FFMPEG_VERSION+x} ]; then \
	FFMPEG=${FFMPEG_HARD}; \
 else \
	FFMPEG=${FFMPEG_VERSION}; \
 fi && \
 echo "**** static x265 fix ****" && \
 sed -i \
	's/-lgcc_s//g' \
	/usr/local/lib/pkgconfig/x265.pc && \
 echo "**** grabbing ffmpeg ****" && \
 mkdir -p /tmp/ffmpeg && \
 echo "https://ffmpeg.org/releases/ffmpeg-${FFMPEG}.tar.bz2" && \
 curl -Lf \
        https://ffmpeg.org/releases/ffmpeg-${FFMPEG}.tar.bz2 | \
        tar -jx --strip-components=1 -C /tmp/ffmpeg
RUN \
 echo "**** compiling ffmpeg ****" && \
 cd /tmp/ffmpeg && \
 ./configure \
	--disable-debug \
	--disable-doc \
	--disable-ffplay \
	--disable-ffprobe \
	--enable-avresample \
	--enable-gpl \
	--enable-libaom \
	--enable-libass \
	--enable-libfdk_aac \
	--enable-libfreetype \
	--enable-libkvazaar \
	--enable-libmp3lame \
	--enable-libopencore-amrnb \
	--enable-libopencore-amrwb \
	--enable-libopenjpeg \
	--enable-libopus \
	--enable-libtheora \
	--enable-libvidstab \
	--enable-libvorbis \
	--enable-libvpx \
	--enable-libx264 \
	--enable-libx265 \
	--enable-libxvid \
	--enable-nonfree \
	--enable-openssl \
	--enable-small \
	--enable-stripping \
	--enable-version3 \
	--extra-cflags="-I/usr/local/include --static" \
	--extra-ldflags="-L/usr/local/lib -static" \
	--extra-libs="-lstdc++ -lexpat -ldl -lpthread" \
	--pkg-config-flags="--static" && \
 make && \
 echo "**** arrange files ****" && \
 mkdir -p /buildout/usr/local/bin && \
 cp \
	/tmp/ffmpeg/ffmpeg \
	/buildout/usr/local/bin

# Runtime stage
FROM lsiobase/alpine:3.9

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="TheLamer"

# copy local files
COPY --from=buildstage /buildout/ /
