FROM python:3.9.7-buster
# ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y vim

RUN pip install --upgrade pip
RUN python3 -m pip install jupyterlab

WORKDIR /app

RUN python3 -m pip install --upgrade pip \
&&  pip install --no-cache-dir \
    jupyterlab \
    jupyterlab_code_formatter \
    jupyterlab-git \
    lckr-jupyterlab-variableinspector \
    jupyterlab_widgets \
    ipywidgets \
    import-ipynb \
    pandas \
    matplotlib \
    numpy \
    scipy

COPY . .
# 既存の内容

# Arial.ttf をコンテナ内の適切なディレクトリにコピー
COPY Arial.ttf /usr/share/fonts/truetype/

# フォントキャッシュを更新
RUN fc-cache -f -v

# matplotlib のフォントリストを更新
RUN python -c "import matplotlib.pyplot as plt; plt.rcParams['font.sans-serif'] = ['Arial']; plt.rcParams['font.family'] = 'sans-serif'"
