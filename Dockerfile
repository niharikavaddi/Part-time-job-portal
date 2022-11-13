FROM python:3-alpine3.7
RUN mkdir /app
WORKDIR /app
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY requirements.txt .
RUN \
apk add -u zlib-dev jpeg-dev gcc musl-dev && \
apk add --no-cache postgresql-libs && \
apk add --no-cache --virtual .build-deps gcc musl-dev postgresql-dev && \
pip install -r requirements.txt --no-cache-dir && \
apk --purge del .build-deps
COPY . /app/
EXPOSE 8000
CMD [ "python","manage.py","runserver","0.0.0.0:8000" ]