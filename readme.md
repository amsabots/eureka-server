### EUREKA SERVICE REGISTRY   
The eureka service registry server is a service used to register
microservice client service. This service will handle internal 
network DNS name resolution to client IP i.e _it will map the human readable
name to a client service running on a specific IP and port_

## Configuration
- The service listens on port - 8761
- The web based console runs on url _http://server-ip:8761_
- >**Very important::** Remember for any micro service that is configured to register 
  > with Eureka server it must specify a unique name - _should be easy to remember_
  > For example a microservice for sending main should have the property 
  > ``spring.application.name=Eureka-server`` specified

Providing a name for your application will help to maintain a
constant identity for your microservice instead of the 
registry server providing a random one

## Connecting to the Eureka server
To register your microservice with eureka server, just provide
the following configuration settings to your `application.properties`
or `application.yml`;
### application.yml
```yaml
spring:
application:
name: spring-cloud-eureka-client
server:
port: 0
eureka:
client:
serviceUrl:
defaultZone: ${EUREKA_URI:http://localhost:8761/eureka}
instance:
preferIpAddress: true
```
### application.properties
```properties
#The url pointing to the eureka server 
eureka.client.serviceUrl.defaultZone  = http://localhost:8761/eureka
eureka.client.instance.preferIpAddress = true
#application name - should be custom
spring.application.name = eurekaclient
```

## usage
To use the eureka client service to request a service 
via REST  
**first**:  
- Confirm the name of the service as shown from the eureka server web GUI.
- Autowire the rest template in your application code

 ```java
import org.springframework.beans.factory.annotation.Autowired;

@Autowired
RestTemplate restTemplate;
```
>conventionally you would call a rest API using the 
> request protocol i.e http or https then url/ip and port if
> necessary then the resource i.e /resource-to-fetch
> #### for example  
> http://localhost:[port]/resource-to-fetch

With eureka discovery, caring about the Ip and port is taken care of
implicitly by the discovery service via a registry system just 
like how IP tables work in networking

so instead of that you will provide your request parameters as follows
#### with eureka 
http://service-name-as-shown-in-eureka-gui/resource  

## Things to note:
- Ensure that Eureka service application starts ahead of all
services that depends on it.
- Always ensure proxy settings and security protocols allow
requests to and from the eureka server
- Incase you are using spring security or any other spring
security client, make sure the url of eureka is excluded from
all normal security filtering managers