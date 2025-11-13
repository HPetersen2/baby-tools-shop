FROM python:3.9-alpine

WORKDIR /app

COPY . $WORKDIR

RUN python -m pip install -r requirements.txt

EXPOSE 8000

ENTRYPOINT [ "/bin/sh", "python manage.py collectstatic", "python manage.py makemigrations", "python manage.py migrate" ]