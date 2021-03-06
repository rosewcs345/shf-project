Feature: Only members and admins can see members only (hidden) pages

  Background:

    Given the following users exists
      | email                    | admin | is_member |
      | not_a_member@bowsers.com |       | false     |
      | emma@happymutts.com      |       | true      |
      | admin@shf.se             | true  | true      |

    And the following business categories exist
      | name  |
      | Rehab |

    And the following applications exist:
      | first_name | user_email          | company_number | category_name | state    |
      | Emma       | emma@happymutts.com | 5562252998     | Rehab         | accepted |


  Scenario: Visitor cannot see members only pages
    Given I am Logged out
    And I am on the static workgroups page
    Then I should see t("errors.not_permitted")
    And I should not see "Yrkesråd"

  Scenario: Visitor cannot see members only menu
    Given I am Logged out
    And I am on the "landing" page
    Then I should not see t("menus.nav.members.member_pages")

  Scenario: User cannot see members only pages
    Given I am logged in as "not_a_member@bowsers.com"
    And I am on the static workgroups page
    Then I should see t("errors.not_permitted")
    And I should not see "Yrkesråd"

  Scenario: User cannot see members only menu
    Given I am logged in as "not_a_member@bowsers.com"
    And I am on the "landing" page
    Then I should not see t("menus.nav.members.member_pages")

  Scenario: Member can see members only pages
    Given I am logged in as "emma@happymutts.com"
    And  I am on the static workgroups page
    Then I should see "Yrkesråd"
    Then I should not see t("errors.not_permitted")

  Scenario: Member can see members only menu
    Given I am logged in as "emma@happymutts.com"
    And I am on the "landing" page
    Then I should see t("menus.nav.members.member_pages")

  Scenario: Admin can see members only pages
    Given I am logged in as "admin@shf.se"
    And  I am on the static workgroups page
    Then I should see "Yrkesråd"
    Then I should not see t("errors.not_permitted")

  Scenario: Admin can see members only menu
    Given I am logged in as "admin@shf.se"
    And I am on the "landing" page
    Then I should see t("menus.nav.members.member_pages")
