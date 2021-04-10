FROM python:3.9.4-slim-buster

EXPOSE 10080
WORKDIR /app

RUN apt-get update && \
  apt-get install -y --no-install-recommends gcc libc-dev \
  procps iproute2 && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY poetry.lock pyproject.toml uwsgi.ini ./
RUN pip install poetry==1.1.5 && \
  poetry install --no-dev

COPY myapp/ ./myapp/

ENTRYPOINT [ "poetry" ]
CMD [ "run", "uwsgi", "--ini", "uwsgi.ini" ]
