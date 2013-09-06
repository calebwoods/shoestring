module Shoestring
  class Rbenv < Base

    def check
      check_for_rvm
      Shoestring::Homebrew.check('rbenv', 'https://github.com/sstephenson/rbenv', 'rbenv') { %x(rbenv --version 2>&1); $?.success? }
      Shoestring::Homebrew.check('ruby-build', 'https://github.com/sstephenson/ruby-build', 'ruby-build') { %x(rbenv --version 2>&1); $?.success? }
      Shoestring::Generic.check('rbenv configured') do
        unless system('echo $PATH | grep "$(rbenv root)/shims" > /dev/null')
          puts "rbenv not initialize in .bash_profile."
          puts "Add the following line to your .bash_profile or equivalent and rerun."
          abort('if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi')
        end
        true
      end
    end

    private

    def check_for_rvm
      if system('which rvm')
        abort('RVM is installed and must be removed to use rbenv. See RVM website for details: http://rvm.io/rvm/cli')
      end
    end

  end
end
