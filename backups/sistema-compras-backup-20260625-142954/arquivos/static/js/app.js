const money = value => new Intl.NumberFormat('pt-BR', {style: 'currency', currency: 'BRL'}).format(Number(value || 0));

document.addEventListener('DOMContentLoaded', () => {
  const sidebar = document.getElementById('sidebar');
  const backdrop = document.getElementById('sidebarBackdrop');
  document.getElementById('sidebarToggle')?.addEventListener('click', () => {
    sidebar.classList.toggle('show'); backdrop.classList.toggle('show');
  });
  backdrop?.addEventListener('click', () => {
    sidebar.classList.remove('show'); backdrop.classList.remove('show');
  });
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

function initOrderForm() {
  const form = document.getElementById('orderForm');
  const product = document.getElementById('productSelect');
  const calculate = () => {
    const quantity = parseFloat(form.quantidade.value) || 0;
    const price = parseFloat(form.preco_negociado.value) || 0;
    const freight = parseFloat(form.frete.value) || 0;
    document.getElementById('orderTotal').textContent = money(quantity * price + freight);
  };
  form.querySelectorAll('.calc-total').forEach(field => field.addEventListener('input', calculate));
  product.addEventListener('change', () => loadProductHistory(product.value));
  calculate(); if (product.value) loadProductHistory(product.value);
}

async function loadProductHistory(productId) {
  const target = document.getElementById('productHistory'); if (!productId) return;
  target.innerHTML = '<div class="empty-history"><span>Consultando histórico...</span></div>';
  try {
    const response = await fetch(`/api/produtos/${productId}/historico`);
    if (!response.ok) throw new Error('Falha na consulta');
    const data = await response.json();
    const date = data.ultima_data ? new Date(`${data.ultima_data}T12:00:00`).toLocaleDateString('pt-BR') : '-';
    target.innerHTML = `<div class="history-row"><span>Último preço pago</span><strong>${data.ultimo_preco ? money(data.ultimo_preco) : '-'}</strong></div><div class="history-row"><span>Preço médio histórico</span><strong>${data.preco_medio ? money(data.preco_medio) : '-'}</strong></div><div class="history-row"><span>Última compra</span><strong>${date}</strong></div><div class="history-row"><span>Último fornecedor</span><strong>${data.ultimo_fornecedor || '-'}</strong></div><div class="history-row"><span>Prazo médio de entrega</span><strong>${data.prazo_medio ? Math.round(Number(data.prazo_medio)) + ' dias' : '-'}</strong></div>`;
  } catch (error) {
    target.innerHTML = '<div class="empty-history text-danger"><span>Não foi possível carregar o histórico.</span></div>';
  }
}

function renderCategoryChart(items) {
  const canvas = document.getElementById('categoryChart'); if (!canvas || typeof Chart === 'undefined') return;
  new Chart(canvas, {type:'doughnut',data:{labels:items.map(i=>i.categoria),datasets:[{data:items.map(i=>Number(i.total)),backgroundColor:['#4353e6','#24b47e','#f6ad55','#ed6474','#58a6e7','#9b7be7'],borderWidth:0,hoverOffset:5}]},options:{responsive:true,maintainAspectRatio:false,cutout:'68%',plugins:{legend:{position:'bottom',labels:{usePointStyle:true,boxWidth:8,padding:16,font:{size:10}}},tooltip:{callbacks:{label:context=>` ${context.label}: ${money(context.raw)}`}}}}});
}
