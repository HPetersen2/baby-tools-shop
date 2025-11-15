FROM python:3.9-alpine

WORKDIR /app

COPY . .

RUN python -m pip install -r requirements.txt

EXPOSE 8000

ENTRYPOINT [ "./entrypoint.sh" ]
