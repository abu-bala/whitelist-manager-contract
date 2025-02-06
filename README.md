# Whitelist Manager Contract

This repository contains a Clarity smart contract for managing a whitelist of addresses with admin control. The contract allows an admin to add users to a whitelist, ensuring secure and efficient management of whitelisted users.

## Features

- **Admin Control:** Only the admin can manage the whitelist.
- **Whitelist Management:** Add users to the whitelist.
- **Contract Metadata:** Includes versioning and descriptive metadata.

## Contract Details

- **Admin:** The contract deployer is set as the admin.
- **Paused State:** The contract includes a paused state variable for future extensibility.
- **Versioning:** The contract version is set to `1.0.0`.

## Functions

### `initialize`

Initializes the contract by setting the deployer as the admin.

### `add-whitelist`

Adds a user to the whitelist. Only callable by the admin.

## Usage

1. **Deploy the Contract:** Deploy the contract to the Stacks blockchain.
2. **Initialize:** Call the `initialize` function to set the admin.
3. **Manage Whitelist:** Use the `add-whitelist` function to add users to the whitelist.

## Development

To contribute to this project, clone the repository and make your changes. Ensure that your code adheres to the project's coding standards and passes all tests.
