require 'spec_helper'

require 'models/dcr/program'
require 'models/dcr/command'

RSpec.describe Dcr::Command do
  let(:program) { Dcr::Program.new }
  
  describe '::create' do
    it 'creates a forward command' do
      expect(described_class.create(program: program, text: 'forward')).to be_a(Dcr::Command::Forward)
      expect(described_class.create(program: program, text: 'forwar')).to be_a(Dcr::Command::Forward)
      expect(described_class.create(program: program, text: 'forwa')).to be_a(Dcr::Command::Forward)
      expect(described_class.create(program: program, text: 'forw')).to be_a(Dcr::Command::Forward)
      expect(described_class.create(program: program, text: 'for')).to be_a(Dcr::Command::Forward)
      expect(described_class.create(program: program, text: 'fo')).to be_a(Dcr::Command::Forward)
      expect(described_class.create(program: program, text: 'f')).to be_a(Dcr::Command::Forward)
      # TODO test more cases for fuzz factor, such as 'frward', 'orward', etc...
    end
    
    it 'creates a backward command' do
      expect(described_class.create(program: program, text: 'backward')).to be_a(Dcr::Command::Backward)
      expect(described_class.create(program: program, text: 'backwar')).to be_a(Dcr::Command::Backward)
      expect(described_class.create(program: program, text: 'backwa')).to be_a(Dcr::Command::Backward)
      expect(described_class.create(program: program, text: 'backw')).to be_a(Dcr::Command::Backward)
      expect(described_class.create(program: program, text: 'back')).to be_a(Dcr::Command::Backward)
      expect(described_class.create(program: program, text: 'bac')).to be_a(Dcr::Command::Backward)
      expect(described_class.create(program: program, text: 'ba')).to be_a(Dcr::Command::Backward)
      expect(described_class.create(program: program, text: 'b')).to be_a(Dcr::Command::Backward)
    end
    
    it 'creates a right command' do
      expect(described_class.create(program: program, text: 'right')).to be_a(Dcr::Command::Right)
      expect(described_class.create(program: program, text: 'righ')).to be_a(Dcr::Command::Right)
      expect(described_class.create(program: program, text: 'rig')).to be_a(Dcr::Command::Right)
      expect(described_class.create(program: program, text: 'ri')).to be_a(Dcr::Command::Right)
      expect(described_class.create(program: program, text: 'r')).to be_a(Dcr::Command::Right)
    end
  end
end
