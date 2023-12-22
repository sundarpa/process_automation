#! /pkg/qct/software/python/sles12/3.9.4/bin/python3

import pandas as pd
import os

def int_to_base3_binary_and_yn(n):
#    print(n)
    binary_str = ''
    n = int(n)
    if n == 0:
        binary_str = '0'
    while n > 0:
        digit = n % 3
        binary_str = str(digit) + binary_str
        n = n // 3

    # Determine the width based on the binary representation
    width = max(3, len(binary_str))
    binary_str = binary_str.zfill(width)  # Pad with zeros
#    print("binary_str",binary_str)

    result = []
    for digit in binary_str:
        if digit == '0':
            result.append('-')
        elif digit == '1':
            result.append('Y')
        elif digit == '2':
            result.append('N')
#    print("sku_data",result)
    return result


def convert_to_binary_and_fill_columns(df, headings):
    # Replace empty values in the first column with 0

#	print(headings)
	full_dataframe = df
	print(headings)
	full_dataframe = df
	print(df)

	df['qultivate_value_encoded'].fillna(0, inplace=True)

    # Apply the function to the DataFrame column and split into separate columns
	df = df['qultivate_value_encoded'].apply(int_to_base3_binary_and_yn).apply(lambda x: pd.Series(x))
    # Define your external headings
	external_headings = [headings]

    # Ensure the number of columns in the DataFrame matches the number of external headings
    
	df = df.fillna('-').astype(str)



    # Ensure the number of columns in the DataFrame matches the number of external headings

	df = df.fillna('-').astype(str)
	# print(df)

    # Rearrange the columns to start from the maximum column to the minimum column
	df.columns = [f'col{i + 1}' for i in range(df.shape[1])]

	if len(df.columns) != len(headings) and len(headings) != 0:
		count = len(headings) - len(df.columns)
		col=['cols'+str(x) for x in range(1,count+1)]
		df[col]='-'

    # Rename the columns

=======
	# print(df)

	df.columns = [headings]
#	print("rename columns",len(df.columns))

	idx = full_dataframe.columns.get_loc('qultivate_value_encoded')
	final_df = pd.concat([full_dataframe.iloc[:, :idx + 1], df, full_dataframe.iloc[:, idx + 1:]], axis=1)

	start_column_name = 'qultivate_value_encoded'
	for column in final_df.columns[final_df.columns.get_loc(start_column_name) + 1:]:
		final_df.rename(columns ={column: column[0]}, inplace=True)

	df_without_data = final_df.drop(columns=['qultivate_value_encoded'])

	return df_without_data


def convert_to_binary_and_int(df, headings):
	df.columns = df.loc[0]
	df = df.drop(0)
    # Convert 'Y' and 'N' to binary values for columns from 'Sheet2'
	for col in headings:
		df[col] = df[col].apply(lambda x: 1 if x == 'Y' else 2 if x == 'N' else 0)

    # Convert binary columns back to integer 'qultivate_value_encoded' column
	df['qultivate_value_encoded'] = df[headings].apply(lambda row: int(''.join(map(str, row)), 3), axis=1)

    # Find the index of the first heading from 'Sheet2'
	first_heading_index = df.columns.get_loc(headings[0])

    # Insert 'qultivate_value_encoded' column before the first heading from 'Sheet2'
	df.insert(first_heading_index, 'qultivate_value_encoded', df.pop('qultivate_value_encoded'))

    # Drop the heading columns taken from Sheet2
	df.drop(columns=headings, inplace=True)

	return df


def qultivate_sku_fill_values(final_df_sheet1):
	sku_columns = [col for col in final_df_sheet1.columns if col.startswith('SKU_')]
	def determine_final_value(row):
		values = [row[col] for col in sku_columns]
		values = ','.join(values)
		if 'Y' in values.split(','):
			return 'Y'
		elif 'N' in values.split(','):
			return 'N'
		else:
			return '-'
	for sku_column in sku_columns:
		final_df_sheet1[sku_column] = final_df_sheet1.apply(lambda row:determine_final_value(row), axis=1)
	return final_df_sheet1

def coloring_y_values(val):
	color = 'background-color: red' if val == 'Y' else 'background-color: yellow' if val == '-' else ''
	return color


def fill_qultivate_enable_values(row):
	if 'Y' in row.values:
		return 'Y'
	return 'N'

def load_csv_to_excel(csv_file, excel_file):
	df = pd.read_csv(csv_file)
	sheet_name = os.path.splitext(os.path.basename(csv_file))[0]
	df.to_excel(excel_file, index=False, sheet_name=sheet_name)

