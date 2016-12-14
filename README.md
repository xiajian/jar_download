# JarDownload


jar download is used to download jar file from maven repoistroy

想法来源自： http://jingyan.baidu.com/article/22fe7ced3b0a003002617fd1.html , 将其中操作步骤，封装成一个 gem， 自动化处理这一系列的步骤。

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
jar_download mysql-connector-java mysql 5.1.27                   
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

## 服务器上安装 maven

```
yum install maven
```

修改 maven 配置，设置成阿里云的源： 

```
# vi /etc/maven/settings.xml 找到 mirrors 块，加入如下行
<mirror>
  <id>alimaven</id>
  <name>aliyun maven</name>
  <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
  <mirrorOf>central</mirrorOf>
</mirror>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

库中核心方法： 

```
  class PomXML
    attr_accessor :group_id, :jar_name, :version
    
    def initialize(jar_info = {})
        @group_id, @jar_name, @version = jar_info[:group_id], jar_info[:jar_name], jar_info[:version]
    end
  end
  
  def get_jar_info
    {
      group_id: 'mysql',
      jar_name: 'mysql-connector-java',
      version: '5.1.27'
    }
  end
  
  def generate_pom_xml(jar_info = get_jar_info)
    filename = File.join(File.dirname(__FILE__), "jar_download/pom.xml.erb")
    erb = ERB.new(File.read(filename))
    erb.filename = filename
    pom_xml = erb.def_class(PomXML, 'render()')
    
    result = pom_xml.new(jar_info).render()
    
    p result
    
    result
  end
  
  def command(jar_info = get_jar_info)
    FileUtils.mkdir_p("/tmp/jar_download")
    pwd = FileUtils.pwd
    
    File.open '/tmp/jar_download/pom.xml', 'w' do |file|
      file.write generate_pom_xml(jar_info)
    end
    
    system "cd /tmp/jar_download; mvn -f pom.xml dependency:copy-dependencies; cp -r target/dependency/*.jar #{pwd}"
  end
```

真正用到服务器上时，需要在服务器上安装 maven， 发现速度还不如直接用 scp 将 jar 包拷贝上去来的方便。 只能本地用用，真是失败。

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/jar_download. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

