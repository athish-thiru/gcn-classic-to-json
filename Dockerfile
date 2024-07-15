FROM python:3.12 AS build
ENV POETRY_VIRTUALENVS_CREATE false
RUN curl -sSL https://install.python-poetry.org | python -
COPY . /src
WORKDIR /src
RUN $HOME/.local/bin/poetry install --only main

FROM python:3.12-slim
COPY --from=build /usr/local/lib/python3.12/site-packages/ /usr/local/lib/python3.12/site-packages/
COPY --from=build /src/ /src/
COPY --from=build /usr/local/bin/gcn-classic-to-json /usr/local/bin/
ENTRYPOINT ["gcn-classic-to-json"]
USER nobody:nogroup
