# --------------------------------------
# Auth: Abhijeet Chopra
# Date: Sun Sep 24, 2017
# Desc: Quick Conda Guide
# --------------------------------------



# verify that conda is installed
conda --version
# update conda to the current version
conda update conda
# create a new environment
conda create --name environment_one biopython
    # this creates a new environment named "environment_one" with the program biopython

# activate the new environment
activate environment_one

# create a new environment with different python version
conda create --name environment_two python=3.5 astroid babel
    # this creates a new environment named "environment_two" with python 3, astroid and babel installed
	
# display the environment that you have installed so far
conda info --envs

# verify the current environment (conda puts and askerisk (*) in front of the active environment)
conda info --envs

# create an environment with "conda create":
conda create --name snowflakes python=3

# to activate the new environment: 
activate snowflakes

# delete the snowflakes environment
conda remove --name snowflakes --all

# switch to another environment
    activate environment_one
	
# change your path from current environment back to the root
deactivate

# make a copy of the environment_one by creating a clone 
conda create --name environment_three --clone environment_one




# MANAGING PYTHON
#---------------------------------------
# check python versions available to install and run
conda search --full-name python

# MANAGING PACKAGES
#---------------------------------------
# list packages and versions installed in an environment
conda list

# search for a package available for conda to install
conda search packagename

# install beautifulsoup4 into the current environment
conda install --name environment_one beautifulsoup4

# INSTALLING PACKAGE FROM ANACONDA.ORG
#---------------------------------------
# installing bottleneck from ANACONDA.ORG
conda install --channel http://conda.anaconda.org/pandas bottleneck

# To install numpy:
conda install -c anaconda numpy
# To install scipy:
conda install -c anaconda scipy

# INSTALLING VIA PIP
#---------------------------------------
# installing package 'see' using pip
pip install see


# to see list of installed packages
conda list

# To update Navigator
conda update anaconda-navigator

# To update Spyder
conda update spyder











# END OF FILE
# --------------------------------------