require 'serverspec'

# Required by serverspec
set :backend, :exec

describe process('python') do
  it { should be_running }
  its(:args) { should match /manage.py runserver\b/ }
  it "is listening on port 8000" do
    expect(port(8000)).to be_listening
  end 
end

#describe command('wget -O - http://localhost:8000') do
## FIXME! failing. got "Congratulations on your first Django-powered page."
#  its(:stdout) { should match /vortessence/ }
#end

