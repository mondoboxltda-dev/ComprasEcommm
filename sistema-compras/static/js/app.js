const money = value => new Intl.NumberFormat('pt-BR', {style: 'currency', currency: 'BRL'}).format(Number(value || 0));
const escapeHtml = value => String(value ?? '').replace(/[&<>"']/g, char => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[char]));
const formatQuantity = value => Number(value || 0).toLocaleString('pt-BR', {minimumFractionDigits: 0, maximumFractionDigits: 4});
const isSuspiciousPurchaseUnit = unit => ['PALLET', 'CX', 'CAIXA', 'ROLO'].includes(String(unit || '').toUpperCase());
const formatDateBR = value => value ? new Date(`${value}T12:00:00`).toLocaleDateString('pt-BR') : '-';
let productHistoryChart = null;

document.addEventListener('DOMContentLoaded', () => {
  const sidebar = document.getElementById('sidebar');
  const backdrop = document.getElementById('sidebarBackdrop');
  document.getElementById('sidebarToggle')?.addEventListener('click', () => {
    sidebar.classList.toggle('show'); backdrop.classList.toggle('show');
  });
  backdrop?.addEventListener('click', () => {
    sidebar.classList.remove('show'); backdrop.classList.remove('show');
  });
  initSearchableComboboxes();
  fitMetricText();
});

window.addEventListener('resize', () => fitMetricText());

document.addEventListener('click', event => {
  const button = event.target.closest('[data-product-history-id]');
  if (button) loadProductHistoryModal(button.dataset.productHistoryId);
});

function clearForm(formId) {
  const form = document.getElementById(formId); form.reset();
  const id = form.querySelector('[name="id"]'); if (id) id.value = '';
  form.querySelectorAll('.select-search').forEach(input => {
    input.value = '';
    filterSelectOptions(input);
  });
}

function fillForm(formId, data) {
  const form = document.getElementById(formId);
  form.querySelectorAll('.select-search').forEach(input => {
    input.value = '';
    filterSelectOptions(input);
  });
  Object.entries(data).forEach(([key, value]) => {
    const field = form.elements.namedItem(key); if (!field) return;
    if (value && typeof value === 'string' && /^\w{3}, \d{2} \w{3} \d{4}/.test(value)) {
      field.value = new Date(value).toISOString().slice(0, 10);
    } else field.value = value ?? '';
  });
}

function confirmDelete() { return window.confirm('Deseja realmente excluir este registro?'); }

function filterSelectOptions(input) {
  const select = document.getElementById(input.dataset.filterSelect);
  if (!select) return;
  const term = input.value.trim().toLocaleLowerCase('pt-BR');
  [...select.options].forEach(option => {
    if (!option.value) {
      option.hidden = false;
      return;
    }
    option.hidden = term && !option.text.toLocaleLowerCase('pt-BR').includes(term);
  });
  if (select.selectedOptions[0]?.hidden) select.value = '';
}

document.addEventListener('input', event => {
  if (event.target.matches('.select-search')) filterSelectOptions(event.target);
});

function initSearchableComboboxes(root = document) {
  root.querySelectorAll('select[data-combobox]:not([data-combobox-ready])').forEach(select => {
    select.dataset.comboboxReady = 'true';
    select.classList.add('combobox-native-select');
    const placeholder = select.dataset.placeholder || select.options[0]?.text || 'Selecione';
    const wrapper = document.createElement('div');
    wrapper.className = 'searchable-combobox';
    const selected = select.selectedOptions[0];
    wrapper.innerHTML = `<div class="searchable-combobox-control">
      <input class="searchable-combobox-input" type="text" autocomplete="off" placeholder="${escapeHtml(placeholder)}">
      <button class="searchable-combobox-clear" type="button" aria-label="Limpar selecao" hidden><i class="bi bi-x"></i></button>
      <button class="searchable-combobox-toggle" type="button" aria-label="Abrir opcoes"><i class="bi bi-chevron-down"></i></button>
    </div><div class="searchable-combobox-menu" role="listbox"></div>`;
    select.parentNode.insertBefore(wrapper, select);
    wrapper.appendChild(select);
    const input = wrapper.querySelector('.searchable-combobox-input');
    const clear = wrapper.querySelector('.searchable-combobox-clear');
    const toggle = wrapper.querySelector('.searchable-combobox-toggle');
    const menu = wrapper.querySelector('.searchable-combobox-menu');
    const options = [...select.options].filter(option => option.value).map(option => ({value: option.value, text: option.textContent.trim()}));

    const syncInput = () => {
      const option = select.selectedOptions[0];
      input.value = option?.value ? option.textContent.trim() : '';
      clear.hidden = !select.value;
      input.title = input.value;
    };
    const close = () => wrapper.classList.remove('open');
    const open = () => {
      render(input.value);
      wrapper.classList.add('open');
    };
    const choose = option => {
      select.value = option.value;
      select.dispatchEvent(new Event('change', {bubbles: true}));
      syncInput();
      close();
    };
    const render = term => {
      const normalized = String(term || '').trim().toLocaleLowerCase('pt-BR');
      const matches = options.filter(option => option.text.toLocaleLowerCase('pt-BR').includes(normalized));
      menu.innerHTML = matches.length ? matches.map((option, index) => `<button class="searchable-combobox-option${index === 0 ? ' active' : ''}" type="button" data-value="${escapeHtml(option.value)}" title="${escapeHtml(option.text)}">${escapeHtml(option.text)}</button>`).join('') : '<div class="searchable-combobox-empty">Nenhuma opcao encontrada.</div>';
    };

    syncInput();
    input.addEventListener('focus', open);
    input.addEventListener('input', () => {
      clear.hidden = !input.value && !select.value;
      render(input.value);
      wrapper.classList.add('open');
    });
    input.addEventListener('keydown', event => {
      if (event.key === 'Escape') {
        syncInput();
        close();
      }
      if (event.key === 'Enter') {
        const first = menu.querySelector('.searchable-combobox-option');
        if (first) {
          event.preventDefault();
          choose(options.find(option => option.value === first.dataset.value));
        }
      }
    });
    input.addEventListener('blur', () => {
      setTimeout(() => {
        if (!wrapper.contains(document.activeElement)) {
          const exact = options.find(option => option.text.toLocaleLowerCase('pt-BR') === input.value.trim().toLocaleLowerCase('pt-BR'));
          if (exact) choose(exact);
          else syncInput();
          close();
        }
      }, 120);
    });
    clear.addEventListener('click', () => {
      select.value = '';
      select.dispatchEvent(new Event('change', {bubbles: true}));
      input.value = '';
      clear.hidden = true;
      input.focus();
      open();
    });
    toggle.addEventListener('click', () => {
      wrapper.classList.contains('open') ? close() : open();
      input.focus();
    });
    menu.addEventListener('mousedown', event => event.preventDefault());
    menu.addEventListener('click', event => {
      const button = event.target.closest('.searchable-combobox-option');
      if (!button) return;
      choose(options.find(option => option.value === button.dataset.value));
    });
  });
}

document.addEventListener('click', event => {
  document.querySelectorAll('.searchable-combobox.open').forEach(wrapper => {
    if (!wrapper.contains(event.target)) wrapper.classList.remove('open');
  });
});

function fitMetricText() {
  document.querySelectorAll('.metric-fit-text').forEach(element => {
    element.style.fontSize = '';
    const max = parseFloat(getComputedStyle(element).fontSize) || 22;
    let size = max;
    while (element.scrollWidth > element.clientWidth && size > 13) {
      size -= 1;
      element.style.fontSize = `${size}px`;
    }
    element.title = element.textContent.trim();
  });
}

let orderConsumptionData = null;
let selectedOrderProduct = null;

function initOrderForm() {
  const form = document.getElementById('orderForm');
  const product = document.getElementById('productSelect');
  const supplier = document.getElementById('supplierSelect');
  const parcelCount = document.getElementById('parcelCount');
  const calculate = () => {
    const quantity = parseFloat(form.quantidade.value) || 0;
    const price = parseFloat(form.preco_negociado.value) || 0;
    const freight = parseFloat(form.frete.value) || 0;
    const total = quantity * price + freight;
    document.getElementById('orderTotal').textContent = money(total);
    const baseCost = document.getElementById('orderBaseCost');
    if (baseCost && selectedOrderProduct) {
      const factor = Number(selectedOrderProduct.quantidade_por_unidade_compra || 1) || 1;
      const baseQty = quantity * factor;
      const baseUnit = selectedOrderProduct.unidade_base || selectedOrderProduct.unidade || '';
      const basePrice = baseQty > 0 ? total / baseQty : 0;
      baseCost.textContent = baseQty > 0 ? `Qtd. base: ${formatQuantity(baseQty)} ${baseUnit} | Custo estimado: ${money(basePrice)} por ${baseUnit}` : 'Quantidade x preco + frete';
    } else if (baseCost) {
      baseCost.textContent = 'Quantidade x preco + frete';
    }
    renderCategoryConsumption(total);
  };
  window.calculateOrderTotal = calculate;
  form.querySelectorAll('.calc-total').forEach(field => field.addEventListener('input', calculate));
  supplier?.addEventListener('change', () => loadSupplierProducts(supplier.value, null));
  product.addEventListener('change', () => {
    loadProductHistory(product.value, true);
    loadCategoryConsumption(product.value);
  });
  form.data_preenchimento?.addEventListener('change', () => loadCategoryConsumption(product.value));
  parcelCount?.addEventListener('change', () => renderInstallments());
  renderInstallments();
  if (supplier?.value) loadSupplierProducts(supplier.value, window.initialProductId || null);
  calculate();
}

async function loadSupplierProducts(supplierId, selectedProductId = null) {
  const preserveCurrent = Boolean(selectedProductId);
  const product = document.getElementById('productSelect');
  const noProducts = document.getElementById('noSupplierProducts');
  product.innerHTML = '<option value="">Selecione um fornecedor primeiro</option>';
  product.disabled = true;
  noProducts?.classList.add('d-none');
  if (!preserveCurrent) clearOrderProductContext();
  if (!supplierId) return;
  const response = await fetch(`/api/fornecedores/${supplierId}/produtos`);
  const items = await response.json();
  product.innerHTML = '<option value="">Selecione...</option>';
  items.forEach(item => product.insertAdjacentHTML('beforeend', `<option value="${item.id}">${item.codigo} - ${item.descricao}</option>`));
  product.disabled = !items.length;
  if (!items.length) noProducts?.classList.remove('d-none');
  if (selectedProductId) {
    product.value = String(selectedProductId);
    if (product.value) {
      loadProductHistory(product.value, false);
      loadCategoryConsumption(product.value);
    }
  }
}

function clearOrderProductContext() {
  const form = document.getElementById('orderForm');
  const product = document.getElementById('productSelect');
  if (product) product.value = '';
  if (form?.preco_negociado) form.preco_negociado.value = '';
  document.getElementById('productHistory').innerHTML = '<div class="empty-history"><i class="bi bi-search"></i><span>Selecione um produto para consultar o historico.</span></div>';
  document.getElementById('categoryConsumption').innerHTML = '<div class="empty-history"><i class="bi bi-pie-chart"></i><span>Selecione um produto para ver o consumo da categoria.</span></div>';
  orderConsumptionData = null;
  selectedOrderProduct = null;
  window.calculateOrderTotal?.();
}

function renderInstallments() {
  const countField = document.getElementById('parcelCount');
  const target = document.getElementById('installmentsFields');
  if (!countField || !target) return;
  const count = Number(countField.value || 1);
  const existing = window.initialInstallmentTerms ? String(window.initialInstallmentTerms).split(',').map(Number) : [];
  target.innerHTML = '';
  for (let index = 1; index <= count; index += 1) {
    const value = existing[index - 1] || index * 30;
    target.insertAdjacentHTML('beforeend', `<div><label class="form-label">${index}a parcela - Prazo em dias *</label><input class="form-control" type="number" min="0" name="prazos_parcelas[]" value="${value}" required></div>`);
  }
  window.initialInstallmentTerms = '';
}

async function loadProductHistory(productId, suggestPrice = false) {
  const target = document.getElementById('productHistory');
  if (!productId) return;
  const supplierId = document.getElementById('supplierSelect')?.value || '';
  target.innerHTML = '<div class="empty-history"><span>Consultando historico...</span></div>';
  try {
    const response = await fetch(`/api/produtos/${productId}/historico?fornecedor_id=${encodeURIComponent(supplierId)}`);
    if (!response.ok) throw new Error('Falha na consulta');
    const data = await response.json();
    selectedOrderProduct = data.produto || null;
    let latest = data.ultima_compra;
    const summary = data.resumo || {};
    if (!latest && supplierId) {
      const fallback = await fetch(`/api/produtos/${productId}/historico`);
      const fallbackData = await fallback.json();
      latest = fallbackData.ultima_compra;
      if (suggestPrice && latest?.valor_unitario) {
        const priceField = document.querySelector('[name="preco_negociado"]');
        priceField.value = Number(latest.valor_unitario).toFixed(2);
        priceField.dispatchEvent(new Event('input', {bubbles:true}));
      }
    } else if (suggestPrice && latest?.valor_unitario) {
      const priceField = document.querySelector('[name="preco_negociado"]');
      priceField.value = Number(latest.valor_unitario).toFixed(2);
      priceField.dispatchEvent(new Event('input', {bubbles:true}));
    }
    const date = latest?.data_entrada ? new Date(`${latest.data_entrada}T12:00:00`).toLocaleDateString('pt-BR') : '-';
    const product = data.produto || {};
    const conversionAlert = Number(product.quantidade_por_unidade_compra || 1) === 1 && isSuspiciousPurchaseUnit(product.unidade) ? '<div class="alert alert-warning mt-2 mb-0">Verifique a quantidade por unidade de compra deste produto. O calculo do valor unitario pode estar incorreto.</div>' : '';
    target.innerHTML = `<div class="history-row"><span>Unidade de compra</span><strong>${product.unidade || '-'}</strong></div><div class="history-row"><span>Qtd. por unidade</span><strong>${formatQuantity(product.quantidade_por_unidade_compra || 1)} ${product.unidade_base || product.unidade || ''}</strong></div><div class="history-row"><span>Ultimo preco compra</span><strong>${latest ? money(latest.valor_unitario) : '-'}</strong></div><div class="history-row"><span>Ultimo preco base</span><strong>${latest ? money(latest.valor_unitario_base) : '-'}</strong></div><div class="history-row"><span>Media com fornecedor</span><strong>${summary.preco_medio ? money(summary.preco_medio) : '-'}</strong></div><div class="history-row"><span>Media base</span><strong>${summary.preco_medio_base ? money(summary.preco_medio_base) : '-'}</strong></div><div class="history-row"><span>Ultima compra com fornecedor</span><strong>${date}</strong></div><div class="history-row"><span>Quantidade comprada</span><strong>${Number(summary.quantidade_total || 0).toLocaleString('pt-BR')} ${product.unidade || ''}</strong></div><div class="history-row"><span>Quantidade base</span><strong>${Number(summary.quantidade_total_base || 0).toLocaleString('pt-BR')} ${product.unidade_base || ''}</strong></div><div class="history-row"><span>Compras anteriores</span><strong>${summary.total_compras || 0}</strong></div><div class="history-row"><span>Media geral base</span><strong>${data.preco_medio_base_geral ? money(data.preco_medio_base_geral) : '-'}</strong></div>${conversionAlert}`;
    window.calculateOrderTotal?.();
  } catch (error) {
    target.innerHTML = '<div class="empty-history text-danger"><span>Nao foi possivel carregar o historico.</span></div>';
  }
}

async function loadCategoryConsumption(productId) {
  if (!productId) return;
  const target = document.getElementById('categoryConsumption');
  const refDate = document.querySelector('[name="data_preenchimento"]')?.value || '';
  target.innerHTML = '<div class="empty-history"><span>Consultando consumo da categoria...</span></div>';
  try {
    const response = await fetch(`/api/produtos/${productId}/consumo_categoria?data_ref=${encodeURIComponent(refDate)}`);
    if (!response.ok) throw new Error('Falha na consulta');
    orderConsumptionData = await response.json();
    window.calculateOrderTotal?.();
  } catch (error) {
    orderConsumptionData = null;
    target.innerHTML = '<div class="empty-history text-danger"><span>Nao foi possivel carregar o consumo da categoria.</span></div>';
  }
}

function renderCategoryConsumption(orderValue = 0) {
  const target = document.getElementById('categoryConsumption');
  if (!target || !orderConsumptionData || orderConsumptionData.error) return;
  const form = document.getElementById('orderForm');
  const budget = Number(orderConsumptionData.orcamento || 0);
  const consumed = Number(orderConsumptionData.consumido || 0);
  const hasBudget = Boolean(orderConsumptionData.tem_orcamento);
  const after = consumed + Number(orderValue || 0);
  const balance = budget - after;
  const percent = hasBudget && budget > 0 ? after / budget * 100 : 0;
  let status = 'Sem orcamento';
  let statusClass = 'status-badge';
  if (hasBudget) {
    status = percent > 100 ? 'Orcamento estourado' : (percent >= 80 ? 'Atencao' : 'Dentro do orcamento');
    statusClass = percent > 100 ? 'status-inativo' : (percent >= 80 ? 'status-pendente' : 'status-ativo');
  }
  const currentQty = Number(form?.quantidade?.value || 0);
  const currentUnit = orderConsumptionData.unidade || 'UN';
  const currentQuantities = new Map((orderConsumptionData.quantidades || []).map(item => [item.unidade || 'UN', Number(item.quantidade || 0)]));
  const afterQuantities = new Map(currentQuantities);
  if (currentQty > 0) afterQuantities.set(currentUnit, (afterQuantities.get(currentUnit) || 0) + currentQty);
  const renderQuantityLines = values => {
    const rows = [...values.entries()].filter(([, quantity]) => Number(quantity) > 0);
    if (!rows.length) return '-';
    return rows.map(([unit, quantity]) => `${formatQuantity(quantity)} ${escapeHtml(unit)}`).join('<br>');
  };
  const noBudgetAlert = !hasBudget ? '<div class="alert alert-secondary mt-2 mb-0">Nao existe orcamento cadastrado para esta categoria no mes atual.</div>' : '';
  const overBudgetAlert = hasBudget && after > budget ? `<div class="alert alert-warning mt-2 mb-0">Essa compra fara a categoria ultrapassar o orcamento mensal.<br><strong>Orcamento estourado em ${money(Math.abs(balance))}</strong></div>` : '';
  target.innerHTML = `<div class="history-row"><span>Categoria</span><strong>${escapeHtml(orderConsumptionData.categoria)}</strong></div><div class="history-row"><span>Referencia</span><strong>${escapeHtml(orderConsumptionData.referencia || '-')}</strong></div><div class="history-row"><span>Orcamento mensal</span><strong>${hasBudget ? money(budget) : '-'}</strong></div><div class="history-row"><span>Valor ja utilizado</span><strong>${money(consumed)}</strong></div><div class="history-row"><span>Ordem atual</span><strong>${money(orderValue)}</strong></div><div class="history-row"><span>Total apos compra</span><strong>${money(after)}</strong></div><div class="history-row"><span>Saldo restante</span><strong>${hasBudget ? money(balance) : '-'}</strong></div><div class="history-row"><span>Consumo</span><strong>${hasBudget ? `${percent.toFixed(2)}%` : '-'}</strong></div><div class="history-row"><span>Quantidade ja comprada</span><strong>${renderQuantityLines(currentQuantities)}</strong></div><div class="history-row"><span>Quantidade da ordem atual</span><strong>${currentQty > 0 ? `${formatQuantity(currentQty)} ${escapeHtml(currentUnit)}` : '-'}</strong></div><div class="history-row"><span>Quantidade apos compra</span><strong>${renderQuantityLines(afterQuantities)}</strong></div><div class="history-row"><span>Status</span><strong><span class="status-badge ${statusClass}">${status}</span></strong></div>${noBudgetAlert}${overBudgetAlert}`;
}

function renderCategoryChart(items) {
  const canvas = document.getElementById('categoryChart'); if (!canvas || typeof Chart === 'undefined') return;
  new Chart(canvas, {type:'doughnut',data:{labels:items.map(i=>i.categoria),datasets:[{data:items.map(i=>Number(i.total)),backgroundColor:['#4353e6','#24b47e','#f6ad55','#ed6474','#58a6e7','#9b7be7'],borderWidth:0,hoverOffset:5}]},options:{responsive:true,maintainAspectRatio:false,cutout:'68%',plugins:{legend:{position:'bottom',labels:{usePointStyle:true,boxWidth:8,padding:16,font:{size:10}}},tooltip:{callbacks:{label:context=>` ${context.label}: ${money(context.raw)}`}}}}});
}

async function loadProductHistoryModal(productId) {
  const body = document.getElementById('historyBody');
  if (!body || !productId) return;
  body.innerHTML = '<div class="empty-history"><span>Carregando historico...</span></div>';
  try {
    const response = await fetch(`/api/produtos/${productId}/historico`);
    if (!response.ok) throw new Error('Falha na consulta');
    const data = await response.json();
    const product = data.produto || {};
    const summary = data.resumo || {};
    const latest = data.ultima_compra;
    document.getElementById('historyTitle').textContent = `${product.codigo || ''} - ${product.descricao || ''}`;
    document.getElementById('historySubtitle').textContent = `Unidade compra ${product.unidade || '-'} | ${formatQuantity(product.quantidade_por_unidade_compra || 1)} ${product.unidade_base || product.unidade || ''} por unidade | Categoria ${product.categoria || '-'}`;
    document.getElementById('fullHistoryLink').href = `/historico-compras?codigo=${encodeURIComponent(product.codigo || '')}`;
    const conversionAlert = Number(product.quantidade_por_unidade_compra || 1) === 1 && isSuspiciousPurchaseUnit(product.unidade)
      ? '<div class="alert alert-warning">Verifique a quantidade por unidade de compra deste produto. O calculo do valor unitario pode estar incorreto.</div>'
      : '';
    const priceAlert = data.alerta_percentual > 0
      ? `<div class="alert alert-warning">Este produto esta ${data.alerta_percentual.toFixed(1)}% acima do preco medio das ultimas compras.</div>`
      : '';
    const purchases = data.ultimas_compras || [];
    body.innerHTML = `${conversionAlert}${priceAlert}<div class="history-kpis">
      <div><span>Ultima compra</span><strong>${latest ? money(latest.valor_unitario) : '-'}</strong><small>${latest ? formatDateBR(latest.data_entrada) : '-'}</small></div>
      <div><span>Ultimo preco base</span><strong>${latest ? money(latest.valor_unitario_base) : '-'}</strong><small>${product.unidade_base || ''}</small></div>
      <div><span>Ultimo fornecedor</span><strong>${latest ? escapeHtml(latest.fornecedor) : '-'}</strong></div>
      <div><span>Preco medio</span><strong>${summary.preco_medio ? money(summary.preco_medio) : '-'}</strong></div>
      <div><span>Preco medio base</span><strong>${summary.preco_medio_base ? money(summary.preco_medio_base) : '-'}</strong></div>
      <div><span>Menor preco</span><strong>${summary.menor_preco ? money(summary.menor_preco) : '-'}</strong></div>
      <div><span>Maior preco</span><strong>${summary.maior_preco ? money(summary.maior_preco) : '-'}</strong></div>
      <div><span>Qtd. total</span><strong>${formatQuantity(summary.quantidade_total || 0)}</strong><small>${product.unidade || ''}</small></div>
      <div><span>Qtd. total base</span><strong>${formatQuantity(summary.quantidade_total_base || 0)}</strong><small>${product.unidade_base || ''}</small></div>
      <div><span>Total comprado</span><strong>${money(summary.valor_total_comprado || 0)}</strong></div>
      <div><span>Melhor fornecedor</span><strong>${data.melhor_fornecedor ? escapeHtml(data.melhor_fornecedor.fornecedor) : '-'}</strong><small>${data.melhor_fornecedor ? money(data.melhor_fornecedor.preco_medio) : ''}</small></div>
    </div><div class="chart-wrap mt-3"><canvas id="productHistoryChart"></canvas></div>
    <div class="table-responsive mt-3"><table class="table modern-table"><thead><tr><th>Data</th><th>Fornecedor</th><th>Documento</th><th>Qtd. compra</th><th>Qtd. base</th><th>Valor unidade compra</th><th>Valor base</th><th>Total</th><th>Origem</th></tr></thead><tbody>${purchases.length ? purchases.map(row => `<tr><td>${formatDateBR(row.data_entrada)}</td><td>${escapeHtml(row.fornecedor)}</td><td>${escapeHtml(row.documento || '-')}</td><td>${formatQuantity(row.quantidade)} ${escapeHtml(row.unidade_compra || product.unidade || '')}</td><td>${formatQuantity(row.quantidade_total_base || 0)} ${escapeHtml(row.unidade_base || product.unidade_base || '')}</td><td>${money(row.valor_unitario)}</td><td>${money(row.valor_unitario_base)}</td><td>${money(row.valor_total)}</td><td>${escapeHtml(row.origem)}</td></tr>`).join('') : '<tr><td colspan="9" class="empty-state">Nenhuma compra encontrada.</td></tr>'}</tbody></table></div>`;
    const ctx = document.getElementById('productHistoryChart');
    if (ctx && typeof Chart !== 'undefined') {
      if (productHistoryChart) productHistoryChart.destroy();
      const valueLabelPlugin = {
        id: 'valueLabelPlugin',
        afterDatasetsDraw(chart) {
          const {ctx: chartCtx} = chart;
          const dataset = chart.data.datasets[0];
          const meta = chart.getDatasetMeta(0);
          chartCtx.save();
          chartCtx.font = '600 10px Inter, system-ui, sans-serif';
          chartCtx.fillStyle = '#30384e';
          chartCtx.textAlign = 'center';
          chartCtx.textBaseline = 'bottom';
          meta.data.forEach((point, index) => {
            const value = Number(dataset.data[index] || 0);
            if (!Number.isFinite(value)) return;
            chartCtx.fillText(money(value), point.x, point.y - 8);
          });
          chartCtx.restore();
        }
      };
      productHistoryChart = new Chart(ctx, {
        type: 'line',
        data: {
          labels: (data.grafico || []).map(row => formatDateBR(row.data_entrada)),
          datasets: [
            {label:'Valor base',data:(data.grafico || []).map(row => row.valor_unitario_base),borderColor:'#4353e6',backgroundColor:'rgba(67,83,230,.12)',pointBackgroundColor:'#4353e6',pointBorderColor:'#4353e6',pointRadius:4,pointHoverRadius:5,tension:.25,fill:true}
          ]
        },
        options: {
          responsive:true,
          maintainAspectRatio:false,
          layout:{padding:{top:24}},
          plugins:{legend:{display:false},tooltip:{callbacks:{label:context => ` ${money(context.raw)}`}}},
          scales:{y:{grace:'12%'}}
        },
        plugins:[valueLabelPlugin]
      });
    }
  } catch (error) {
    body.innerHTML = '<div class="empty-history text-danger"><span>Nao foi possivel carregar o historico do produto.</span></div>';
  }
}

let orderSupplierProducts = [];

function initOrderForm() {
  const form = document.getElementById('orderForm');
  if (!form) return;
  const supplier = document.getElementById('supplierSelect');
  const parcelCount = document.getElementById('parcelCount');
  const addButton = document.getElementById('addOrderItem');
  const freightMode = document.getElementById('freightMode');
  const generalFreight = document.getElementById('generalFreight');
  window.calculateOrderTotal = calculateMultiOrderTotal;
  parcelCount?.addEventListener('change', () => renderInstallments());
  supplier?.addEventListener('change', () => loadSupplierProducts(supplier.value, null));
  addButton?.addEventListener('click', () => addOrderItemRow());
  freightMode?.addEventListener('change', calculateMultiOrderTotal);
  generalFreight?.addEventListener('input', calculateMultiOrderTotal);
  renderInstallments();
  if (supplier?.value) {
    loadSupplierProducts(supplier.value, null).then(() => {
      const initial = window.initialOrderItems || [];
      if (initial.length) initial.forEach(item => addOrderItemRow({
        produto_id: item.produto_id,
        quantidade: item.quantidade,
        preco_negociado: item.preco_negociado,
        frete: item.frete
      }));
      if (!initial.length) addOrderItemRow();
      calculateMultiOrderTotal();
    });
  } else {
    addOrderItemRow();
  }
}

async function loadSupplierProducts(supplierId) {
  orderSupplierProducts = [];
  const noProducts = document.getElementById('noSupplierProducts');
  noProducts?.classList.add('d-none');
  if (!supplierId) {
    document.getElementById('orderItemsBody').innerHTML = '';
    addOrderItemRow();
    return [];
  }
  const response = await fetch(`/api/fornecedores/${supplierId}/produtos`);
  orderSupplierProducts = await response.json();
  if (!orderSupplierProducts.length) noProducts?.classList.remove('d-none');
  document.querySelectorAll('.order-product-select').forEach(select => populateOrderProductSelect(select, select.value));
  return orderSupplierProducts;
}

function populateOrderProductSelect(select, selected = '') {
  select.innerHTML = '<option value="">Selecione...</option>';
  orderSupplierProducts.forEach(item => {
    select.insertAdjacentHTML('beforeend', `<option value="${item.id}" ${String(selected) === String(item.id) ? 'selected' : ''}>${escapeHtml(item.codigo)} - ${escapeHtml(item.descricao)}</option>`);
  });
  select.disabled = !orderSupplierProducts.length;
}

function addOrderItemRow(item = {}) {
  const body = document.getElementById('orderItemsBody');
  if (!body) return;
  const row = document.createElement('tr');
  row.className = 'order-item-row';
  row.innerHTML = `
    <td><select class="form-select form-select-sm order-product-select" name="produto_id[]" required></select></td>
    <td><input class="form-control form-control-sm order-item-calc" type="number" min="0.01" step="0.01" name="quantidade[]" value="${item.quantidade || ''}" required></td>
    <td><div class="input-group input-group-sm"><span class="input-group-text">R$</span><input class="form-control order-item-calc" type="number" min="0" step="0.01" name="preco_negociado[]" value="${item.preco_negociado || ''}" required></div></td>
    <td><div class="input-group input-group-sm"><span class="input-group-text">R$</span><input class="form-control order-item-freight order-item-calc" type="number" min="0" step="0.01" name="frete_item[]" value="${item.frete || 0}" required></div></td>
    <td><strong class="order-item-total">R$ 0,00</strong></td>
    <td><small class="order-item-meta text-muted">-</small></td>
    <td><button type="button" class="btn btn-icon text-danger order-remove-item"><i class="bi bi-trash"></i></button></td>
  `;
  body.appendChild(row);
  const select = row.querySelector('.order-product-select');
  populateOrderProductSelect(select, item.produto_id || '');
  select.addEventListener('change', () => {
    warnDuplicateOrderProduct(select);
    updateOrderItemMeta(row);
    loadProductHistory(select.value, false);
    calculateMultiOrderTotal();
  });
  row.querySelectorAll('.order-item-calc').forEach(input => input.addEventListener('input', calculateMultiOrderTotal));
  row.querySelector('.order-remove-item').addEventListener('click', () => {
    if (document.querySelectorAll('.order-item-row').length <= 1) return;
    row.remove();
    calculateMultiOrderTotal();
  });
  updateOrderItemMeta(row);
  calculateMultiOrderTotal();
}

function warnDuplicateOrderProduct(select) {
  if (!select.value) return;
  const same = [...document.querySelectorAll('.order-product-select')].filter(item => item.value === select.value);
  if (same.length > 1 && !window.confirm('Este produto ja esta no pedido. Deseja manter separado? Clique em Cancelar para escolher outro produto.')) {
    select.value = '';
  }
}

function getOrderProduct(productId) {
  return orderSupplierProducts.find(item => String(item.id) === String(productId)) || null;
}

function updateOrderItemMeta(row) {
  const product = getOrderProduct(row.querySelector('.order-product-select')?.value);
  const target = row.querySelector('.order-item-meta');
  if (!target) return;
  if (!product) {
    target.textContent = '-';
    return;
  }
  target.textContent = `${product.categoria || '-'} | ${product.unidade || '-'} | ${formatQuantity(product.quantidade_por_unidade_compra || 1)} ${product.unidade_base || product.unidade || ''}`;
}

async function calculateMultiOrderTotal() {
  const rows = [...document.querySelectorAll('.order-item-row')];
  const freightMode = document.getElementById('freightMode')?.value || 'individual';
  const generalFreight = Number(document.getElementById('generalFreight')?.value || 0);
  let subtotal = 0;
  const rowData = rows.map(row => {
    const qty = Number(row.querySelector('[name="quantidade[]"]')?.value || 0);
    const price = Number(row.querySelector('[name="preco_negociado[]"]')?.value || 0);
    const freightField = row.querySelector('[name="frete_item[]"]');
    const base = qty * price;
    subtotal += base;
    return {row, qty, price, freightField, base};
  });
  let total = 0;
  const categoryTotals = new Map();
  rowData.forEach(item => {
    const product = getOrderProduct(item.row.querySelector('.order-product-select')?.value);
    let freight = Number(item.freightField?.value || 0);
    if (freightMode === 'geral') {
      freight = subtotal > 0 ? item.base / subtotal * generalFreight : 0;
      if (item.freightField) item.freightField.value = freight.toFixed(2);
    }
    item.freightField.disabled = freightMode === 'geral';
    const itemTotal = item.base + freight;
    total += itemTotal;
    item.row.querySelector('.order-item-total').textContent = money(itemTotal);
    if (product) {
      const category = product.categoria || 'Sem categoria';
      categoryTotals.set(category, (categoryTotals.get(category) || 0) + itemTotal);
      const factor = Number(product.quantidade_por_unidade_compra || 1) || 1;
      const baseQty = item.qty * factor;
      item.row.querySelector('.order-item-meta').textContent = `${category} | ${product.unidade || '-'} | Base: ${formatQuantity(baseQty)} ${product.unidade_base || product.unidade || ''}`;
    }
  });
  document.getElementById('orderTotal').textContent = money(total);
  document.getElementById('orderBaseCost').textContent = `${rows.length} item(ns) no pedido`;
  await renderMultiCategoryConsumption(categoryTotals);
}

async function renderMultiCategoryConsumption(categoryTotals) {
  const target = document.getElementById('categoryConsumption');
  if (!target) return;
  const selectedProducts = [...document.querySelectorAll('.order-product-select')].map(select => select.value).filter(Boolean);
  if (!selectedProducts.length) {
    target.innerHTML = '<div class="empty-history"><i class="bi bi-pie-chart"></i><span>Adicione produtos para ver o consumo por categoria.</span></div>';
    return;
  }
  const refDate = document.querySelector('[name="data_preenchimento"]')?.value || '';
  const dataByCategory = new Map();
  for (const productId of selectedProducts) {
    try {
      const response = await fetch(`/api/produtos/${productId}/consumo_categoria?data_ref=${encodeURIComponent(refDate)}`);
      const data = await response.json();
      if (!dataByCategory.has(data.categoria)) dataByCategory.set(data.categoria, data);
    } catch {}
  }
  target.innerHTML = [...categoryTotals.entries()].map(([category, orderValue]) => {
    const data = dataByCategory.get(category) || {};
    const budget = Number(data.orcamento || 0);
    const consumed = Number(data.consumido || 0);
    const hasBudget = Boolean(data.tem_orcamento);
    const after = consumed + orderValue;
    const balance = budget - after;
    const percent = hasBudget && budget > 0 ? after / budget * 100 : 0;
    const status = !hasBudget ? 'Sem orcamento' : (after > budget ? 'Orcamento estourado' : 'Dentro do orcamento');
    const statusClass = !hasBudget ? '' : (after > budget ? 'status-inativo' : 'status-ativo');
    return `<div class="order-category-box"><strong>${escapeHtml(category)}</strong>
      <div class="history-row"><span>Orcamento mensal</span><strong>${hasBudget ? money(budget) : '-'}</strong></div>
      <div class="history-row"><span>Valor ja utilizado</span><strong>${money(consumed)}</strong></div>
      <div class="history-row"><span>Ordem atual</span><strong>${money(orderValue)}</strong></div>
      <div class="history-row"><span>Total apos compra</span><strong>${money(after)}</strong></div>
      <div class="history-row"><span>Saldo restante</span><strong>${hasBudget ? money(balance) : '-'}</strong></div>
      <div class="history-row"><span>Consumo</span><strong>${hasBudget ? `${percent.toFixed(2)}%` : '-'}</strong></div>
      <div class="history-row"><span>Status</span><strong><span class="status-badge ${statusClass}">${status}</span></strong></div>
    </div>`;
  }).join('');
}
