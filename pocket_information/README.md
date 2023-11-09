# Elixir Archetype

This project is an **Elixir** boilerplate that can be used to kickstart a webservice in **Elixir**.

The structure of the project is based on Clean Architecture (Hexagonal Architecture defined in Bancolombia).

## What is Hexagonal Architecture (Clean Architecture)?

The Hexagonal Architecture, also known as the architecture of ports and adapters, has as its main motivation to separate our application into different layers or regions with their own responsibility. In this way, it manages to decouple layers of our application, allowing them to evolve in isolation. In addition, having the system separated by responsibilities will facilitate reuse.

More details about this architecture: [Clean Architecture — Aislando los detalles](https://medium.com/bancolombia-tech/clean-architecture-aislando-los-detalles-4f9530f35d7a)

## Project Structure

    .
        ├── ...
        ├── lib							
        │   ├── adapters				# Specialization of a interface for a specific context.
        │   │   ├── repositories		
        │   ├── domain					# The core of the layers which is not attached to anything external.
        │   │   ├── gateways			# Defines the expected behavior of the infrastructure using interfaces.
        │   │   ├── model				# Encapsulates business logic and rules through models and domain entities.
        │   │   ├── usecases			# Encapsulates the rules and processes defined by the business.
        │   ├── entry_points			# Defines and groups the set of controllers, which allows it to expose the capabilities of the use cases.
        │   │   ├── http
        │   │   │   ├── rest
        │   ├── utils					# General purpose reusable utilities.
        │   ├── application.ex			# Main entry point of the app.
        │   └── ...						# etc.
        └── ...

Further information about this project structure can be found at: [Estructura de un proyecto elixir con una Arquitectura Hexagonal (Arquitectura Limpia)](https://grupobancolombia.visualstudio.com/Vicepresidencia%20Servicios%20de%20Tecnolog%C3%ADa/_wiki/wikis/Vicepresidencia%20Servicios%20de%20Tecnolog%C3%ADa.wiki/34491/Estructura-de-un-proyecto-elixir-con-una-Arquitectura-Hexagonal-%28Arquitectura-Limpia%29)
