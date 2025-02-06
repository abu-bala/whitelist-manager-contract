# Whitelist Manager Contract

This repository contains a Clarity smart contract for managing a whitelist of addresses with admin control. The contract allows an admin to add or remove users from the whitelist, ensuring secure and efficient management of whitelisted users.

## Features

- **Admin Control:** Only the admin can manage the whitelist.
- **Whitelist Management:** Add, remove, and batch process users.
- **Pause Functionality:** Temporarily disable contract operations.
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

### `remove-whitelist`

Removes a user from the whitelist. Only callable by the admin.

### `add-whitelist-batch`

Adds multiple users to the whitelist in a single transaction.

### `pause` / `unpause`

Pauses or unpauses the contract operations.

### `get-whitelist-count`

Returns the total number of whitelisted addresses.

## Usage

1. **Deploy the Contract:** Deploy the contract to the Stacks blockchain.
2. **Initialize:** Call the `initialize` function to set the admin.
3. **Manage Whitelist:** Use the `add-whitelist`, `remove-whitelist`, and `add-whitelist-batch` functions to manage users.
4. **Pause Operations:** Use `pause` and `unpause` to control contract activity.

## Development

To contribute to this project, clone the repository and make your changes. Ensure that your code adheres to the project's coding standards and passes all tests.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

For questions or support, please open an issue in the repository or contact the maintainer.
