# adapt-authoring-docker

The docker images and compose file, help you run an [Adapt Authoring Environment](https://github.com/adaptlearning/adapt_authoring)

Based on [https://github.com/aptlogica/adapt-authoring-docker](https://github.com/aptlogica/adapt-authoring-docker)

# Prerequisites

- Docker and Docker Compose installed and working

## Windows Notes:
The images will work under Docker on Windows, without WSL2, but the performance is lower.

For best performance configure [Docker to use WSL2](https://docs.docker.com/desktop/windows/wsl/)

# Configuration

## Environment Configuration

Set the following environment variables, or create a .env file by copying [.env.example](.env.example) to .env and populating the values.

| ENV            | Required | Description                                                                                                    | Default in .env.example              |
| -------------- | -------- | -------------------------------------------------------------------------------------------------------------- | ------------------------------------ |
| AAT_VER        | Required | Version of Adapt Authoring Tool (AAT) to install see https://github.com/adaptlearning/adapt_authoring/releases | 0.10.5                               |
| AAT_HOST_PORT  | Required | This is port that the Adapt Authoring Tool (AAT) is available on                                               | 5000                                 |
| SESSION_SECRET | Required | Session cookies are signed with this 'secret' to prevent tampering                                             | e0b64511-a411-4697-88a9-3541da485f8d |
| ADMIN_EMAIL    | Required | The admin username/email you will login with                                                                   | adapt@localhost.com                  |
| ADMIN_PASSWORD | Required | The admin password you login with                                                                              | Password@123                         |

<br/>

# Running

1. Set up the enironment file.
1. Build the Dockerfile and bring up the containers, best method is run Docker Compose
   ```
   docker compose up -d --build
   ```
1. Open your browser to [http://localhost:5000](http://localhost:5000)
1. Login using the username and password you configured in the .env file for `ADMIN_EMAIL` and `ADMIN_PASSWORD`

# License

MIT © martinholden-skillsoft
