# JarDownload


jar download is used to download jar file from maven repoistroy

想法来源自： http://jingyan.baidu.com/article/22fe7ced3b0a003002617fd1.html。 将其中操作步骤，封装成一个 gem， 自动化处理这一系列的步骤。

NOTE: 依赖系统中需要先安装 maven。

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jar_download'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jar_download    

## Usage

命令行： 


```
Usage: jar_download jar_name group_id version

jar download is used to download jar file from maven repoistroy

v0.1.0

Options:
    -h, --help                       Show command line help
        --version                    Show help/version info
        --verbose                    Be verbose
        --log-level LEVEL            Set the logging level
                                     (debug|info|warn|error|fatal)
                                     (Default: info)
                                     
# 例子使用       
jar_download  mysql-connector-java mysql 5.1.27                   
```

编程使用： 

```
jar_info =     {
      group_id: 'mysql',
      jar_name: 'mysql-connector-java',
      version: '5.1.27'
    }
JarDownload.download jar_info
```                                     


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/jar_download. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

