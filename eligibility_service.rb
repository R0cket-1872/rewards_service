class EligibilityService

    def self.check_eligibility(account_number)
        if account_no_valid?(account_number) #Check for invalid numbers
              if eligible_for_reward?
                  return "CUSTOMER_ELIGIBLE"
              else
                  return "CUSTOMER_INELIGIBLE"
              end
        else
            return "Invalid account number exception"
        end
    end


    #A simple condition to check if an account number is invalid
    #All accounts numbers are valid under 8 characters

    def self.account_no_valid?(account_number)
        if account_number.length > 8
          return false
        else
          return true
        end
    end

    def self.eligible_for_reward? #Set to true
        return false
    end
end
