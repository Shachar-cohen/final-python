# We are saying here that we want to download from docker hub an image of Python version 3.7 slim which is a smaller version of Python
FROM python:3.7-slim

# The application requires a port number to determine which port it should run on. Set the PORT environment variable to 5000 so the application listens on port 5000 by default.
ENV PORT=5000

# Create a directory inside the image to store the application's source code. This gives the application a dedicated location, and in the next step we'll copy all of the project files into this directory.
WORKDIR /app

# According to the README, this project uses Pipenv to manage dependencies, so we install Pipenv before installing the project's packages.
RUN pip install pipenv

# Copying these installation files in a single step locks in the Docker cache. This handles the setup so code changes later won't trigger a full reinstall.
COPY Pipfile Pipfile.lock ./

# This installs the packages inside the container.
RUN pipenv install --system --deploy

# Then, copy the rest of the application code.
COPY . .

# Tells Docker that the container listens on port 5000 at runtime.
EXPOSE 5000

# The command that starts the app when the container starts.
CMD ["python", "app.py"]
