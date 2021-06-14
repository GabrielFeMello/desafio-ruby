require "application_system_test_case"

class TransationsTest < ApplicationSystemTestCase
  setup do
    @transation = transations(:one)
  end

  test "visiting the index" do
    visit transations_url
    assert_selector "h1", text: "Transations"
  end

  test "creating a Transation" do
    visit transations_url
    click_on "New Transation"

    fill_in "Card", with: @transation.card
    fill_in "Date", with: @transation.date
    fill_in "Representative", with: @transation.representative_id
    fill_in "Store", with: @transation.store_id
    fill_in "Time", with: @transation.time
    fill_in "Type", with: @transation.type
    fill_in "Value", with: @transation.value
    click_on "Create Transation"

    assert_text "Transation was successfully created"
    click_on "Back"
  end

  test "updating a Transation" do
    visit transations_url
    click_on "Edit", match: :first

    fill_in "Card", with: @transation.card
    fill_in "Date", with: @transation.date
    fill_in "Representative", with: @transation.representative_id
    fill_in "Store", with: @transation.store_id
    fill_in "Time", with: @transation.time
    fill_in "Type", with: @transation.type
    fill_in "Value", with: @transation.value
    click_on "Update Transation"

    assert_text "Transation was successfully updated"
    click_on "Back"
  end

  test "destroying a Transation" do
    visit transations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Transation was successfully destroyed"
  end
end
