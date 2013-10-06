#!/usr/bin/python
# Copyright (C) 2013 Lucien Xu. <sfietkonstantin@free.fr>
#
# You may use this file under the terms of the BSD license as follows:
#
# "Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#   * Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
#   * Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in
#     the documentation and/or other materials provided with the
#     distribution.
#   * Neither the name of Nemo Mobile nor the names of its contributors
#     may be used to endorse or promote products derived from this
#     software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE." 

# Generates components from a JSON description file
#
# This script generates components from a JSON description file.
# The JSON description file have the following organization
# {
#     "components": [
#         list of components
#     ],
#     "properties": [ list of properties ],
#     "font": "/path/to/some_font.ttf"
# }
#
# The "components" is the list of components that should be generated.
# Each component have a "name", and a list of "properties". A property
# is a list of objects defined this way:
# {
#     "name": "someName",
#     "type": "some_type",
#     ["default": some_value]
# }
# or 
# {
#     "name": "someName",
#     "object": "some_object"
# }
# 
# The first variation defines a simple property. "type" field should
# contain the name of either a basic type, like int, or float, or
# a Qt object, like QColor and QString. The optional "default" field
# contains a default value that is embedded in the component. 
# Properties with default values don't need to be defined in the 
# theme file.
#
# The second variation contains an object definition. Usually, an 
# object defines a complex type, that needs several basic types to be
# defined, like a gradient, that needs 2 colors, and maybe a radius.
#
# The "properties" field of the root object behave the same, and 
# describes the properties that the Theme object have. Note that
# "name" and "description" are automatically provided by the 
# script, and don't need to be defined in the properties.
#
# The last field is the font. It provides the default font that
# is available from the Theme object.

import json
import classgenerator
import argparse

def generate(descriptionFile):
    # First, we try to open JSON description file
    try:
        f = open(descriptionFile)
    except:
        print "Failed to open " + descriptionFile
        return
    
   
    data = json.load(f)
    classgenerator.generate(data, True)
    
    for componentData in data["components"]:
        classgenerator.generate(componentData)

# Main
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Theme helper')
    parser.add_argument('description_file', metavar='description_file', type=str,
                        help="""Input description file (JSON)""")
    args = parser.parse_args()
    description_file = args.description_file
    
    generate(description_file)