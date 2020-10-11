Angular is useful and its potential is in Single Page Applications, where you just update pieces of the page instead of reloading the whole page each interaction.

Angular programs can be written in Typescript

Command line tools :

    node
    npm
    tsc - typescript compiler

Accessors : if empty, public by default

Constructor : you can do it oldschool like in Java, with fields and this.blabla = bla, but you can also define your fields in the constructor param, and they get automatically detected and considered the accessors they have.

# Angular

create new project with ```ng new blabla```
then in the src/app proceed to delete the default content in the html

start the dev mode with ```ng serve```, automatically get hot reloading in ```localhost:4200```

# Creating new component

```
ng generate component any-name

// Generated files after the command

any-name.component.ts : the component class

any-name.component.html : the template HTML of component

any-name.component.css : the component private css

any-name.component.spec.ts : the unit test specifications

UPDATE src/app/app.module.ts : Adds the component to the main application module
```