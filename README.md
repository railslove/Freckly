# Freckly

We built this gem for http://github.com/railslove/Freckly-App

NOTE: It is currently missing quite a few API calls

## How To Install

    sudo gem install campfire_bot

## Example

    require 'rubygems'
    require 'freckly'

    Freckly.token = "token_from_freckly"
    Freckly.subdomain = "my_subdomain"

    # Get all projects
    projects = Freckly::Project.all

    # Get all time entries for a project
    projects.first.entries

    # If you know the ID of a project
    Freckly::Entry.all(:projects => 123)

    # Want the entries of a list of projects
    Freckly::Entry.all(:projects => %w{123 456 789})

    # You can pass any of the options from http://github.com/madrobby/freckle-apidocs/blob/master/entries.mkdn
    Freckly::Entry.find_all_for_project(123, :billable => true, :tags => "fun")

## Note on Patches/Pull Requests

* Fork the project.
* Create a feature branch
* Make your feature addition or bug fix.
* Add tests.
* Commit, do not mess with RakeFile, version, or history.
* Send me a pull request.

## Copyright

Copyright (c) 2010 Red Davis.

## License

The MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.