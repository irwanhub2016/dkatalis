# DKatalis :: This project there are 2 parts: Web and API

###  ⏺ Requirement An Automation Testing Framework for Web
* Assume you are using environment macOS. For this case i'm using macOS and Ruby 2.5.1
* [Ruby](https://www.ruby-lang.org/en/) with version 2.5.0 or above. I recommend to use ruby version manager like [rvm](https://rvm.io/) to install the ruby. Follow the instructions below:
* Install GNUPG `$ brew install gnupg`
* Install Key `gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB`
* Install RVM `$ \curl -sSL https://get.rvm.io | bash`
* Install Ruby `$ rvm install 2.5.1`
* Set use ruby 2.5.1 `$ rvm use 2.5.1`

If you are linux(Ubuntu) please install brew first:
* Install package `sudo apt-get install build-essential curl file git`
* Install brew `sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"`

### Setup
Clone the repository and install all gems depedency:
```shell
$ git clone https://github.com/irwanhub2016/dkatalis.git
$ cd icebox/
$ gem install bundler
$ bundle install
```
Please make sure you have [chromedriver](https://sites.google.com/a/chromium.org/chromedriver/) installed on your system.

`$ brew install chromedriver`

For firefox driver

`$ brew install geckodriver`

And don't forget to also install chrome and firefox browser for the latest version.

This framework contains spesific directory functions:
```
- root directory    => contains configuration files
- features          => main directory, all test will inside this
- data              => store data in yml file that will be using in testing
- helper            => ruby helper files located
- pages             => page class, contains locator strategies for several pages
- scenarios         => cucumber features files
- step_definitions  => code implementation of cucumber feature files
- support           => setup of test framework
```

What are these 3 files?:

1. **Feature** file (.feature) is our automation test steps, written in `gherkin` format (given-when-then-and-or), this file also works as test documentation. 

2. **Page**  file (*_pages.rb) is page object model DSL using SitePrism gem, we should store locator stragies inside class file, one file *_pages.rb can contains multiple class

3. **Steps** file (.rb), which is located in the `step_definitions` folder. Step file's name should also be in the form of `purchase_steps.rb`


### Running Features Test
* We can run test on optional browser using environment variable (.env)
* If you need to run using spesific browser change value firefox => BROWSER=firefox and for chrome => BROWSER=chrome in .env file

To see content .env jump to main directory dkatalis then `$ cat .env`

Run all features: `$ cucumber`

Run spesific test only: `$ cucumber features/purchase.feature:11` or `$ cucumber features/purchase.feature:12`

### Report

Report will generated in folder `report` with filename features_reports.html. Open it with browser.

### Notes
This test use capybara library to find an element and Rspec doing expectation.

### Issue
* There is only an issue from **firefox browser** when i run all scenarios at the same time want and when to switch from from second(child) level frame to main page step.
* But if run scenario one by one `features/purchase.feature:11` then `features/purchase.feature:12` it does not matter
* Related to mozilla bug _Browsing context has been discarded after "WebDriver:SwitchToFrame"_.  

### ⏺ Requirement for API Test
* Assume you are using environment macOS. For this case i'm using macOS and Ruby 2.5.1
* Make sure Ruby has been installed by following the instructions above

This framework contains spesific directory functions:
```
- root directory    => contains configuration files
- lib               => main class, created library for compare JSON
- spec              => code to write test
```

### Run Test
* For the block test `Test API with two JSON data for #{ENV['LOOP']} loop` we can run test  with custom loop. Example update loop number in .env file => LOOP=1000 or you can set anything number except 0.

Run spec: `bundle exec rspec`

Run spec with documentation: `bundle exec rspec --format documentation`

### Notes
This test use Rspec doing expectation and own library to compare two JSON responses ( [json_compare.rb](https://github.com/irwanhub2016/dkatalis/blob/main/API/lib/json_compare.rb) ).
