# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...





<!-- app/views/balance_transfers/new.html.erb -->
<h1>Transfer Balance</h1>
<%= form_with(model: @balance_transfer, url: balance_transfers_path, local: true) do |form| %>
  <% if @balance_transfer.errors.any? %>
    <div id="error_explanation">
      <h2><%= pluralize(@balance_transfer.errors.count, "error") %> prohibited this balance transfer from being saved:</h2>
      <ul>
        <% @balance_transfer.errors.full_messages.each do |message| %>
          <li><%= message %></li>
        <% end %>
      </ul>
    </div>
  <% end %>
  <div class="field">
    <%= form.label :receiver_username %>
    <%= form.text_field :receiver_username %>
  </div>
  <div class="field">
    <%= form.label :amount %>
    <%= form.number_field :amount %>
  </div>
  <div class="field">
    <%= form.label :description %>
    <%= form.text_area :description %>
  </div>
  <div class="actions">
    <%= form.submit %>
  </div>
<% end %>

