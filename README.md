# SGP_Project
## Development

Before you can build this project, you must install and configure the following dependencies on your machine:

1. Node.js: We use Node to run a development web server and build the project.

After installing Node, you should run the following command to install development tools.
You will only need to run this command when dependencies change in [package.json](package.json).

```
npm install
```
We use npm scripts and [Webpack][] as our build system.

Run the following :
```
./mvnw
npm start
```

Npm is used to manage CSS and JavaScript dependencies used in this application. You can upgrade dependencies by
specifying a newer version in [package.json](package.json). 

### Managing dependencies

For example, to add [Leaflet][] library as a runtime dependency , run :
```
npm install --save --save-exact leaflet
```

To benefit from TypeScript type definitions from [DefinitelyTyped][] repository in development, you would run following command:
```
npm install --save-dev --save-exact @types/leaflet
```

### Using Angular CLI

You can also use [Angular CLI][] to generate some custom client code (components).

For example, the following command:

```
ng generate component my-component
```

will generate few files:

```
create src/main/webapp/app/my-component/my-component.component.html
create src/main/webapp/app/my-component/my-component.component.ts
update src/main/webapp/app/app.module.ts
```

## Building for production

### Packaging 

To build the final jar for production, run:

```
./mvnw -Pprod clean verify
```

To package your application as a war , run:

```
./mvnw -Pprod,war clean verify
```

## Testing

To launch your application's tests, run:

```
./mvnw verify
```

### Client tests

Unit tests are run by [Jest][] :

```
npm test
```

### Code quality

Sonar is used to analyse code quality.

```
docker-compose -f src/main/docker/sonar.yml up -d
```

Then, run a Sonar analysis:

```
./mvnw -Pprod clean verify sonar:sonar
```
## Docker


To start a postgresql database in a docker container, run:

```
docker-compose -f src/main/docker/postgresql.yml up -d
```

To stop it and remove the container, run:

```
docker-compose -f src/main/docker/postgresql.yml down
```

To fully dockerize the application and all the services that it depends on.
First build a docker image of the app :

```
./mvnw package -Pprod verify jib:dockerBuild -Denforcer.skip=true -DskipTests
```
Then run:

```
docker-compose -f src/main/docker/app.yml up -d
```

## Continuous Integration

We used as a Continuous Integration systems: Jenkins.
You can check the JenkinsFile to see all the stages defined in our Jenkins Pipeline.
