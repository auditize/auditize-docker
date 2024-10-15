FROM python:3.12-slim

RUN pip install auditize gunicorn

RUN groupadd -r auditize-group && useradd -r -m -g auditize-group auditize-user
USER auditize-user

EXPOSE 80

ENTRYPOINT ["auditize"]
