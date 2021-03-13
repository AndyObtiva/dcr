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
    end
    
    it 'creates a backward command' do
      expect(described_class.create(program: program, text: 'backward')).to be_a(Dcr::Command::Backward)
      expect(described_class.create(program: program, text: 'backwar')).to be_a(Dcr::Command::Backward)
      expect(described_class.create(program: program, text: 'ackward')).to be_a(Dcr::Command::Backward)
      expect(described_class.create(program: program, text: 'backwa')).to be_a(Dcr::Command::Backward)
      expect(described_class.create(program: program, text: 'ackwar')).to be_a(Dcr::Command::Backward)
      expect(described_class.create(program: program, text: 'ckward')).to be_a(Dcr::Command::Backward)
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
    
    it 'creates a left command' do
      expect(described_class.create(program: program, text: 'left')).to be_a(Dcr::Command::Left)
      expect(described_class.create(program: program, text: 'lef')).to be_a(Dcr::Command::Left)
      expect(described_class.create(program: program, text: 'le')).to be_a(Dcr::Command::Left)
      expect(described_class.create(program: program, text: 'l')).to be_a(Dcr::Command::Left)
    end
    
    it 'creates a color command' do
      expect(described_class.create(program: program, text: 'color')).to be_a(Dcr::Command::Color)
      expect(described_class.create(program: program, text: 'colo')).to be_a(Dcr::Command::Color)
      expect(described_class.create(program: program, text: 'col')).to be_a(Dcr::Command::Color)
      expect(described_class.create(program: program, text: 'co')).to be_a(Dcr::Command::Color)
      expect(described_class.create(program: program, text: 'c')).to be_a(Dcr::Command::Color)
    end
    
    it 'creates a repeat command' do
      expect(described_class.create(program: program, text: 'repeat')).to be_a(Dcr::Command::Repeat)
      expect(described_class.create(program: program, text: 'repea')).to be_a(Dcr::Command::Repeat)
      expect(described_class.create(program: program, text: 'repe')).to be_a(Dcr::Command::Repeat)
      expect(described_class.create(program: program, text: 'rep')).to be_a(Dcr::Command::Repeat)
      expect(described_class.create(program: program, text: 're')).to be_a(Dcr::Command::Repeat)
      expect(described_class.create(program: program, text: 'p')).to be_a(Dcr::Command::Repeat)
    end
    
    it 'creates an empty command' do
      expect(described_class.create(program: program, text: '')).to be_a(Dcr::Command::Empty)
    end
  end
end
