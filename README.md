## Synopsis

Pulls in the services output from nagios (/nagios/cgi-bin/config.cgi?type=services). Takes the HTML output and transforms it to json.

This is not an awesome program BTW, it will pull from a local html file, or pull from a nagios server. Just uncomment the HTTPS open command to pull it remotely.

## Code Example

````shell
NAG_URL='https://host/nagios/cgi-bin/config.cgi?type=services' NAG_USER=user NAG_PASS=pass ruby nagios-parser.rb > nagios_services.json
````

## Motivation

To be able to parse the HTML output from a running nagios instance, and output to json. We want this to be able to collect all of our monitored services and annotate them independently of nagios, or to export them to another format outside of nagios.

## Installation

Just git clone, and bundle.

## Tests

No tests

## License

Code released under the MIT license. Docs released under Creative Commons.
