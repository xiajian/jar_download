require "jar_download/version"
require "erb"
require "fileutils"

module JarDownload

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
  
  # 在 temp 目录中生成临时使用的项目，通过这个项目来下载依赖的 jar
  # 不过，maven 或者 ant 应该有方式能直接下载 jar 包的
  def command(jar_info = get_jar_info)
    FileUtils.mkdir_p("/tmp/jar_download")
    pwd = FileUtils.pwd
    
    File.open '/tmp/jar_download/pom.xml', 'w' do |file|
      file.write generate_pom_xml(jar_info)
    end
    
    system "cd /tmp/jar_download; mvn -f pom.xml dependency:copy-dependencies; cp -r target/dependency/*.jar #{pwd}"
  end
  
  extend self
end
