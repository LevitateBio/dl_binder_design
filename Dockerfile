FROM gcr.io/cyrus-containers/alphafold:2.3.2-cuda-11.4.3-ubuntu-18.04

WORKDIR /app/
RUN apt-get update
RUN apt-get upgrade -y

RUN pip install jaxlib packaging

ENV LD_LIBRARY_PATH=/usr/local/cuda/compat:$LD_LIBRARY_PATH

ADD . ./dl_binder_design/

#Dev stuff
#COPY vimrc /.vimrc
#RUN apt-get update && apt-get install -y vim
RUN pip install pyrosetta-installer mock
RUN python -c 'import pyrosetta_installer; pyrosetta_installer.install_pyrosetta()'


RUN cd /app/dl_binder_design/af2_initial_guess &&\
    mkdir -p model_weights/params && cd model_weights/params &&\
    wget https://storage.googleapis.com/alphafold/alphafold_params_2022-12-06.tar &&\
    tar --extract --verbose --file=alphafold_params_2022-12-06.tar 
