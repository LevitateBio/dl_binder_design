FROM gcr.io/cyrus-containers/alphafold:1.0.0-alphafold-2.3.2

WORKDIR /app/
RUN apt-get update
RUN apt-get upgrade -y

RUN pip install jaxlib packaging

ADD . ./dl_binder_design/

#Dev stuff
#COPY vimrc /.vimrc
#RUN apt-get update && apt-get install -y vim
RUN pip install pyrosetta-installer mock
RUN python -c 'import pyrosetta_installer; pyrosetta_installer.install_pyrosetta()'
