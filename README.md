# Patient notes

## Getting started

- Clone the repo

```bash
git clone https://github.com/abeidahmed/patient-notes.git
```

- Install the dependencies

```bash
bundle install && yarn
```

- Setup your database and seed some data

```bash
rails db:setup
```

- Start the server

```bash
foreman start
```

or, run these in separate terminals

```bash
rails s
```

```bash
./bin/webpack-dev-server
```

- Visit `localhost:3000/patients`
- Click on the patient's name and click on `Add a new note` after redirect
- Fill in the note form as desired and click on `Create note`
