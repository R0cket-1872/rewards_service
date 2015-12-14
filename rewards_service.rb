class RewardsService
    require_relative 'eligibility_service'

    attr_accessor :account_no, :customer_tariff, :customer_status

    def initialize
      @tariff_and_rewards = {"3G100MB" => "EXTRA50MB", "3G250MB" => "EXTRA100MB",
                            "3G500MB" => "EXTRA250NB", "3G1000MB" => "EXTRA500MB"}
      @tariff_and_rewards.default = "NOTFOUND"
      @account_no = 0
      @customer_tariff = 0
      @customer_reward = 0
    end

    def prompt
	     print "> "
    end

    def get_customer_details
      puts "Please enter your Account Number"
      @account_no = get_account_number

      get_and_validate_tariff #Moved into separate method because of loop for validation

      @customer_status = EligibilityService.check_eligibility(@account_no) #Check Eligibility Status of Customer

      calculate_reward(@customer_status)
    end

    def calculate_reward(status)
      case status
          when "Invalid account number exception"
            puts "Your account number was invalid"
          when "CUSTOMER_INELIGIBLE"
            puts "You are not eligibile for an reward"
          when "CUSTOMER_ELIGIBLE"
            display_reward(status)
          else
          puts "Technical Service Error"
      end
    end

    def display_reward(status)
      puts "Your reward is #{@tariff_and_rewards[@customer_tariff]}"
    end

    def get_and_validate_tariff
      puts "Enter Your Tariff:"
      while !@tariff_and_rewards.key?(@customer_tariff)
          @customer_tariff = get_customer_tariff
          puts "Your Tariff was not recognised - please try again" if !@tariff_and_rewards.key?(@customer_tariff)
      end
    end

  private

    def get_account_number
        prompt
        gets.chomp
    end

    def get_customer_tariff
        prompt
        gets.chomp
    end
end

  #begin_service = RewardsService.new
  #begin_service.get_customer_details
