require "spec_helper"

describe Rdm::Support::Colorize do
  let(:subject){Rdm::Support::Colorize}
  context "colorize" do
    it "red works" do
      expect(subject.red('hello')).to eq("\e[31mhello\e[0m")
    end

    it "green works" do
      expect(subject.green('hello')).to eq("\e[32mhello\e[0m")
    end

    it "brown works" do
      expect(subject.brown('hello')).to eq("\e[33mhello\e[0m")
    end

    it "all other colors work" do
      method_names = %w(black red  green  brown  blue  magenta  cyan  gray  bg_black  bg_red  bg_green  bg_brown  bg_blue  bg_magenta  bg_cyan  bg_gray  bold  italic  underline  blink  reverse_color  no_colors).map(&:to_sym)
      method_names.each do |m|
        expect(subject.send(m, 'msg')).to match('msg')
      end
    end
  end

  context "no_colors" do
    it "removes colors from string" do
      expect(subject.no_colors(subject.red('hello'))).to eq("hello")
    end
  end
end
