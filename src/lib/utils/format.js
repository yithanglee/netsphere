const DEFAULT_LOCALE = 'en-US';

/**
 * Formats a numeric value with thousand separators.
 *
 * @param {string|number|null|undefined} value
 * @param {{decimals?: number, locale?: string}} [opts]
 * @returns {string}
 */
export function formatNumber(value, opts = {}) {
	const { decimals = 2, locale = DEFAULT_LOCALE } = opts;
	const raw = value == null ? '' : String(value);
	const num = typeof value === 'number' ? value : parseFloat(raw.replace(/,/g, ''));
	const safe = Number.isFinite(num) ? num : 0;

	return new Intl.NumberFormat(locale, {
		useGrouping: true,
		minimumFractionDigits: decimals,
		maximumFractionDigits: decimals
	}).format(safe);
}

/**
 * Formats a NETSPH amount with thousand separators.
 *
 * @param {string|number|null|undefined} value
 * @param {{decimals?: number, position?: 'prefix'|'suffix', locale?: string}} [opts]
 * @returns {string}
 */
export function formatNETSPH(value, opts = {}) {
	const { decimals = 2, position = 'suffix', locale = DEFAULT_LOCALE } = opts;
	const amount = formatNumber(value, { decimals, locale });
	return position === 'prefix' ? `NETSPH ${amount}` : `${amount} NETSPH`;
}


