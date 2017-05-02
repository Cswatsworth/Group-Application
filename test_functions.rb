require 'minitest/autorun'
require_relative 'functions.rb'

class TestPassword < Minitest::Test
	def test_setup
		assert_equal(1,1)
	end

	def test_psw_req
		password = PasswordReqClass.new('Password1')
		assert_equal(true, password.password_requirements)
	end

	def test_psw_req_2
		password = PasswordReqClass.new('Password$')
		assert_equal(false, password.password_requirements)
	end

	def test_psw_req_length
		password = PasswordReqClass.new('Need6')
		assert_equal(false, password.password_requirements)
	end

	def test_passwords_match
		password = PasswordReqClass.new('Password')
		confirm = 'Password'
		assert_equal(true, password.password_match(confirm))
	end

	def test_passwords_match_2
		password = PasswordReqClass.new('Password')
		confirm = 'Password1'
		assert_equal(false, password.password_match(confirm))
	end

	def test_passwords_match_3
		password = PasswordReqClass.new('Password')
		confirm = 'password'
		assert_equal(false, password.password_match(confirm))
	end
end