FROM python:3.9-alpine

WORKDIR /app

COPY . .

RUN python -m pip install -r requirements.txt && \
    chmod +x entrypoint.sh

ENV PORT=8025

EXPOSE 8025

ENTRYPOINT [ "./entrypoint.sh" ]
