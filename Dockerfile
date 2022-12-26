# This is a Dockerfile. This descibres how to programmatically set up
# what's known as a "container". A "container" is sort of a virtual computer
# inside of another computer. Unlike what some of you may be familiar with,
# and "virtual machines", containers are extremely fast to start up,
# and make it easy to share an application packaged with all the components
# needed for it to run. For AVR, we are going to set up containers for
# each module to make it easier to run them all seperately and simultaneously.

# This begins the process of building our container off the standard Python
# image. The version tag (after the colon), is the Python version (3.11).
# https://hub.docker.com/_/python
FROM docker.io/library/python:3.11 AS poetry-exporter

# Change the working directory to /work
WORKDIR /work

# Copy two files from our local machine to the container
COPY pyproject.toml pyproject.toml
COPY poetry.lock poetry.lock

# Install the Python Poetry package manager, and export a requirements.txt file.
RUN python -m pip install poetry \
 && poetry export -o requirements.txt


# Here, we are taking advantage of a feature of the Dockerfile called
# "multi-stage" builds. This allows us to copy files generated from the one stage
# to another. This is helpful to install lots of dependencies in one stage to
# compile some code, then just copy the outputs into a slim final container.
# Because we only needed Poetry to export a requirements.txt file, we don't need
# to keep it installed. Thus, we start a new, fresh, stage.
FROM docker.io/library/python:3.11

# Change the working directory to /app
WORKDIR /app

# Copy the file requirements.txt from the host into the container
COPY --from=poetry-exporter /work/requirements.txt requirements.txt

# First, upgrade pip (Python's package manager) and install a package
# called "wheel". A "wheel" is a Python package format that is basically
# a ZIP file of Python code that is already pre-built. After that,
# install the requirements in the requirements.txt file for our code.
RUN python -m pip install pip wheel --upgrade \
 && python -m pip install -r requirements.txt

# Now, copy everything else in this folder into the container.
COPY src .

# Finally, start the container running our code.
CMD ["python", "sandbox.py"]