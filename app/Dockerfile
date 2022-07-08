FROM python:3.7.3-stretch

## Step 1:
WORKDIR /app

## Step 2:
COPY requirements.txt /app/

## Step 3:
#hadolint ignore=DL3013
RUN pip install --upgrade --no-cache-dir pip &&\
    pip install --trusted-host pypi.python.org --no-cache-dir -r requirements.txt

COPY . app.py /app/

## Step 4:
EXPOSE 80

## Step 5:
CMD ["python", "app.py"]

