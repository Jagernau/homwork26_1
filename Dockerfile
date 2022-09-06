FROM python:3.10-slim

WORKDIR /code
RUN python -m pip install --user virtualenv
RUN python -m virtualenv env
RUN . env/bin/activate
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .
ENV FLASK_APP="app.py"
ENV FLASK_ENV="development"
RUN python create_tables.py
RUN python load_fixtures.py
CMD flask run -h 0.0.0.0 -p 80
