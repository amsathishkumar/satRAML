#!/bin/sh -v
raml validate $1
ramlev $1
raml2html $1 > $1.html
